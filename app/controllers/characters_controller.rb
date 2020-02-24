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
    @owner = @character.user  #don't think it knows about it's user actually....
    @current_user = Helper.current_user(session)
    erb :"characters/show"
  end

  get '/characters/:id/edit' do
    @character = Character.find_by_id(params[:id])
    @list_owner = @character.           #same problem here.....
    if !Helper.logged_in?(session)
      redirect '/'
    end

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
