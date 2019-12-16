class DirectorsController < ApplicationController

    get '/directors' do
        if Helpers.logged_in?(session)
            @user = Helpers.current_user(session)
            @directors = Director.all
            erb :'directors/index'
        else
            flash[:message] = "Please Log in to view all directors"
            erb :'users/login'
        end
    end

    get '/directors/:slug' do
        if Helpers.logged_in?(session)
            @user = Helpers.current_user(session)
            @director = Director.find_by_slug(params[:slug])
            erb :'directors/show'
        else
            flash[:message] = "Please Log in to view this director"
            erb :'users/login'
        end
    end

end