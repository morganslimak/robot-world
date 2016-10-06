require_relative '../models/robot.rb'

class RobotWorldApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)

  get '/robots' do
    @robots = Robot.all
    erb :index
  end

  get '/' do
    erb :dashboard
  end

  get '/robots/new' do
    erb :new
  end

  post '/robots' do
    robot = Robot.new(params[:robot])
    robot.save
    redirect '/robots'
  end

  get '/robots/:id/update' do
    @robot = Robot.find(params[:id])
    erb :update
  end

  set :method_override, true
  put '/robots/:id' do |id|
    Robot.update(id.to_i, params[:robot])
    redirect "/robots"
  end

  delete '/robots/:id/delete' do |id|
    Robot.destroy(id.to_i)
    redirect '/robots'
  end

end
