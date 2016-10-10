require "json"
require "./backend/main"
require "./services/repository"
require "./models/car"
require "./models/rental"

def parse_json(file_path)
  JSON.parse(File.read(file_path))
end
