class DirectorsController < ApplicationController

    get '/directors' do
        @directors = Director.all
        erb :'directors/index'
    end

    get '/directors/:slug' do
        @director = Director.find_by_slug(params[:slug])
        erb :'directors/show'
    end

end