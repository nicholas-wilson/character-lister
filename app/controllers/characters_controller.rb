class CharactersController < ApplicationController
  get '/characters/new' do
    if !Helper.logged_in?(session)
      redirect '/'
    end
    erb :"characters/new"
  end

  get '/characters/:id' do
    if !Helper.logged_in?(session)
      redirect '/'
    end
    @character = Character.find_by_id(params[:id])
    @owner = @character.user
    @current_user = Helper.current_user(session)
    erb :"characters/show"
  end

  get '/characters/:id/edit' do
    if !Helper.logged_in?(session)
      redirect '/'
    end
    @character = Character.find_by_id(params[:id])
    @list_owner = @character.user
    # without a proper character it will load a page saying no such character has been created yet
    # or may just redirect to /home
    if !@character
      redirect '/home'
    end
    erb :"characters/edit"
  end

  post '/characters' do
    if !params[:name] || params[:name] == " "
      redirect '/characters/new'
    end
    user = Helper.current_user(session)
    new_guy = Character.create(params)
    user.characters << new_guy
    redirect "/#{user.username}"
  end
end
