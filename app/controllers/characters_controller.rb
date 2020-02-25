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
    if !params[:character][:name] || params[:character][:name] == " "
      redirect '/characters/new'
    end
    user = Helper.current_user(session)
    new_guy = Character.create(params[:character])
    user.characters << new_guy
    new_guy.update_rank(params[:rank][:list_rank])
    redirect "/#{user.username}"
  end

  patch '/characters/:id' do
    character = Character.find_by_id(params[:id])
    character.update(params[:character])
    character.update_rank(params[:rank][:list_rank])
    redirect "/characters/#{character.id}"
  end
end
