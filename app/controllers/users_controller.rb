class UsersController < ApplicationController

  get '/home' do
    if !Helper.logged_in?(session)
      redirect '/login'
    end
    @user = Helper.current_user(session)
    erb :"users/index"
  end

  get '/signup' do
    if Helper.logged_in?(session)
      redirect '/home'
    end
    erb :"users/signup"
  end

  post '/signup' do
    if params[:username] != "" && params[:password] != ""
      if params[:username].include?(" ") && params[:password].include?(" ")
        redirect '/signup'
      end
      new_person = User.create(params)
      session[:user_id] = new_person.id
      redirect '/home'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if Helper.logged_in?(session)
      redirect '/home'
    end
    erb :"users/login"
  end

  post '/login' do
    if params[:username] != "" && params[:password] != ""
      user = User.find_by(username: params[:username])
      if !!user && user.validate(params[:password])
        session[:user_id] = user.id
        redirect '/home'
      else
        redirect '/login'
      end
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session[:user_id] = ""
    redirect '/login'
  end

  post '/search' do
    user = User.find_by_username(params[:username])

  end

  get '/:username' do   #this route will show a users list
    user = User.find_by_username(params[:username])
    if !user
      redirect '/'
    end
  end
end
