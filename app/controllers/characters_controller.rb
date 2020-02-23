class CharactersController < ApplicationController
  get '/characters/new' do
    if !Helper.logged_in?(session)
      redirect '/'
    end
    erb :"characters/new"
  end

  post '/characters' do
    binding.pry
    if !params[:name] || params[:name] == " "
      redirect '/characters/new'
    end
    user = Helper.current_user(session)
    new_guy = Character.create(params)
    redirect "/#{user.username}"
  end
end
