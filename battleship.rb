require "yaml"
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

Battleship.battle("config.yml")
