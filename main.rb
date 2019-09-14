require 'sass'
require 'sinatra'
require 'sinatra/reloader' if development?
require './song'

configure do
  enable :sessions
  set :username, 'frank'
  set :password, 'sinatra'
end

get('/styles.css'){ scss :styles }

get '/' do
  @title = "Welcome!"
  slim :home
end

get '/about' do
  @title = "All About This Website"
  slim :about
end

get '/contact' do
  @title = "Write us!"
  slim :contact
end

not_found do
  @title = "Whoops!"
  slim :not_found
end

get '/set/:name' do
  session[:name] = params[:name]
end

get '/get/hello' do
  "Hello #{session[:name]}"
end

get '/login' do
  slim :login
end

post '/login' do
  if params[:username] == settings.username && params[:password] == settings.password
    session[:admin] = true
    redirect to('/songs')
  else
    slim :login
  end
end

get '/logout' do
  session.clear
  redirect to('/login')
end
