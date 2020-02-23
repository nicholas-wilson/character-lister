class CharactersController < ApplicationController
  get '/characters/new' do
    erb :"characters/new"
  end
end
