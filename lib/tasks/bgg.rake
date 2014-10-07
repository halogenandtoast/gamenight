require 'nokogiri'
require 'open-uri'
require 'yaml'
require 'continuation'
require 'thread'

desc "Pull BGG data"
namespace :bgg do
  task :pull do
    unless Dir.exists?("tmp/games")
      Dir.mkdir("tmp/games")
    end

    class Pool
      def initialize(size)
        @size = size
        @jobs = Queue.new

        @pool = Array.new(@size) do |i|
          Thread.new do
            Thread.current[:id] = i
            catch(:exit) do
              loop do
                job, args = @jobs.pop
                job.call(*args)
              end
            end
          end
        end
      end

      def schedule(*args, &block)
        @jobs << [block, args]
      end

      def shutdown
        @size.times do
          schedule { throw :exit }
        end

        @pool.map(&:join)
      end
    end

    BASE_URI = "http://boardgamegeek.com"

    xml = Nokogiri::HTML(open("#{BASE_URI}/browse/boardgame"))
    page_count = xml.at_css("a[title='last page']").text.tr("^0-9", "").to_i

    mutex = Mutex.new
    pool = Pool.new(10)

    puts "Count: #{page_count} pages"

    page_count.times.map do |i|
      filename = "tmp/games/games_#{(i + 1).to_s.rjust(3, "0")}.yaml"
      unless File.exists?(filename)
        pool.schedule do
          mutex.synchronize do
            puts "Fetching: /browse/boardgame/page/#{i+1}"
          end

          callcc { |cc| Thread.current[:cc] = cc }

          begin
            xml = Nokogiri::HTML(open("#{BASE_URI}/browse/boardgame/page/#{i+1}"))
            table = xml.at_css("table#collectionitems")

            rows = table.search("tr").drop(1) # dropping the header

            games = rows.map do |row|
              title_node = row.search("td")[2]
              anchor = title_node.at_css("a")
              url = anchor["href"]
              id = url.match(/\/boardgame(?:expansion)?\/([^\/]+).*/)[1]
              title = anchor.text
              year_node = title_node.at_css("span")
              year = if year_node
                       year_node.text[1..-2]
                     end
              { id: id, title: title, year: year }
            end
          rescue Errno::ECONNRESET => e
            sleep 5
            Thread.current[:cc].call
          end

          File.open( filename, 'wb' ) do |out|
            YAML.dump( games.map { |game| game.merge(title: game[:title].unpack('U*').pack('U*').force_encoding("UTF-8")) }, out )
          end
        end
      end
    end

    at_exit do
      pool.shutdown
      puts "Finished retrieving pages"
      puts "Combining #{page_count} pages"
      games = page_count.times.inject([]) { |games, id| games + YAML.load_file("tmp/games/games_%03d.yaml" % (id + 1)) }
      puts "Finished writing: lib/all.yaml"
      File.open("lib/all.yaml", "wb") { |out| YAML.dump(games, out) }
      puts "Finished"
    end
  end

  task update: :environment do
    games = YAML.load_file("lib/all.yaml")
    games.each do |game|
      Game.find_or_create_by(bgg_id: game[:id]) do |new_game|
        puts "Added #{game[:title]}"
        new_game.title = game[:title]
        new_game.year = game[:year]
      end
    end

  end
end
