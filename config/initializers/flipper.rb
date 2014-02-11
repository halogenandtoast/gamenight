require 'flipper/adapters/memory'

$flipper = Flipper.new(Flipper::Adapters::Memory.new)
$flipper[:library].enable if Rails.env.test? || ENV['ENABLE_LIBRARY']
$flipper[:suggestions].enable if Rails.env.test? || ENV['ENABLE_SUGGESTIONS']
