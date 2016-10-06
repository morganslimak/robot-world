require 'sqlite3'

class Robot
  attr_reader :name, :avatar, :id

  def initialize(robot_params)
    @name = robot_params["name"]
    @avatar = robot_params["avatar"]
    @id = robot_params["id"] if robot_params["id"]
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

  def self.find(id)
    robot = database.execute("SELECT * FROM robots WHERE id = ?", id).first
    Robot.new(robot)
  end

  def self.update(id, robot_params)
    database.execute("UPDATE robots
                      SET name = ?,
                          avatar = ?
                      WHERE id = ?;",
                      robot_params[:name],
                      robot_params[:avatar],
                      id)
  end
end
