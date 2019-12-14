require_relative "application_controller.rb"
class ActorsController < ApplicationController

    get '/actors' do
        @actors = Actor.all
        erb :'actors/index'
    end

    get '/actors/:slug' do
        @actor = Actor.find_by_slug(params[:slug])
        erb :'actors/show'
    end

end