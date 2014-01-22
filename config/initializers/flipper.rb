require 'flipper/adapters/memory'

$flipper = Flipper.new(Flipper::Adapters::Memory.new)
$flipper[:library].enable if ENV['ENABLE_LIBRARY']
$flipper[:suggestions].enable if ENV['ENABLE_SUGGESTIONS']
