AMBER_ENV = ARGV[0]? || ENV["AMBER_ENV"]? || "development"

require "option_parser"
require "amber"
require "./**"
require "./*"
require "../config/*"


OptionParser.parse! do |opts|
  opts.on("-p PORT", "--port PORT", "define port to run server") do |opt|
    Amber::Server.instance.port = opt.to_i
  end
end

Amber::Server.instance.config do |app|
  # Server options
  app_path = __FILE__ # Do not change unless you understand what you are doing.
  app.name = "Ambercr.io web application."
  port = ENV["PORT"] || 8080
  app.host = "0.0.0.0"
  app.port = port.to_i
  app.env = ENV.fetch("AMBER_ENV", "development") .colorize(:green).to_s
  app.log = ::Logger.new(STDOUT)
  app.log.level = ::Logger::INFO
end


Amber::Server.instance.run
