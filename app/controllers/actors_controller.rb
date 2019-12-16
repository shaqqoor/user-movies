require_relative "application_controller.rb"
class ActorsController < ApplicationController

    get '/actors' do
        if Helpers.logged_in?(session)
            @user = Helpers.current_user(session)
            @actors = Actor.all
            erb :'actors/index'
        else
            flash[:message] = "Please Log in to view all actors"
            erb :'users/login'
        end
    end

    get '/actors/:slug' do
        if Helpers.logged_in?(session)
            @user = Helpers.current_user(session)
            @actor = Actor.find_by_slug(params[:slug])
            erb :'actors/show'
        else
            flash[:message] = "Please Log in to view this actor"
            erb :'users/login'
        end
    end

end