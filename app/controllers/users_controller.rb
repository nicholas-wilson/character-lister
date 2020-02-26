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
    session.clear
    redirect '/login'
  end

  post '/search' do
    user = User.find_by_username(params[:username])
    if user
      redirect "/#{user.username}"
    else
      redirect '/home'
    end
  end

  get '/:username' do   #this route will show a user's list
    if !Helper.logged_in?(session)
      redirect '/login'
    end
    @current_user = User.find_by_id(session[:user_id])
    @user = User.find_by_username(params[:username])
    if !@user
      redirect '/home'
    end
    @characters = Character.ordered_list(@user)  #check to see if this sorts characters by rank
    erb :"characters/index"
  end
end
