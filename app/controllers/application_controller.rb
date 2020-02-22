require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :layout
  end

  get '/signup' do
    :signup
  end

  post '/signup' do
    if params[:username] != "" && params[:password] != ""
      if params[:username].include?(" ") && params[:password].include?(" ")
        redirect '/signup'
      end
      # then create the user
      redirect '/index'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    if params[:username] != "" && params[:password] != ""
      user = User.find_by(username: params[:username])
      if !!user && user.validate(params[:password])
        session[:user_id] = user.id
        redirect '/index'
      else
        redirect '/login'
      end
    else
      redirect '/login'
    end
  end
end
