require 'sqlite3'

class Robot
  attr_reader :name, :avatar

  def initialize(robot_params)
    @name = robot_params["name"]
    @avatar = robot_params["avatar"]
    @database = SQLite3::Database.new('db/robot_world_development.db')
    @database.results_as_hash = true
  end

  def save
    @database.execute("INSERT INTO robots(name, avatar) VALUES (?, ?);", @name, @avatar)
  end

  def self.database
    database = SQLite3::Database.new('db/robot_world_development.db')
    database.results_as_hash = true
    database
  end

  def self.all
    robots = database.execute("SELECT * FROM robots")
    robots.map do |robot|
      Robot.new(robot)
    end
  end

end
