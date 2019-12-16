class MoviesController < ApplicationController

    get '/movies' do
        if Helpers.logged_in?(session)
            @movies = Movie.all
            erb :'/movies/index'
        else
            flash[:message] = "To browse through movies you'll have to login!"
            erb :'users/login'
        end
    end

    get '/movies/new' do
        if Helpers.logged_in?(session)
            erb :'movies/new'
        else
            flash[:message] = "Please log in to create a new movie!"
            erb :'users/login'
        end
    end

    get '/movies/:slug' do
        if Helpers.logged_in?(session)
            @user = User.find(session[:user_id])
            @movie = Movie.find_by_slug(params[:slug])
            erb :'movies/show'
        else
            flash[:message] = "To view the current movie you'll have to login!"
            erb :'users/login'
        end
    end

    post '/movies' do
        params[:movie][:name] = params[:movie][:name].downcase
        @movie = Movie.find_or_create_by(params[:movie])
        @movie.director = Director.find_or_create_by(name: params[:director].downcase)
        @actors = Actor.find_or_create_actors(params[:actors])
        @movie.actors += @actors
        if @movie.save
            flash[:message] = "Successfully created movie."
            redirect "/movies/#{@movie.slug}"
        else
            flash[:message] = "Unable to create the movie."
            redirect '/failure'
        end
    end

    get '/movies/:slug/edit' do
        if Helpers.logged_in?(session)
            @user = Helpers.current_user(session)
            @movie = Movie.find_by_slug(params[:slug])
            erb :'movies/edit'
        else
            flash[:message] = "To edit the current movie you'll have to login!"
            erb :'users/login'
        end
    end
    
    patch '/movies/:slug' do
        @movie = Movie.find_by_slug(params[:slug])
        @movie.update(params[:movie])
        @movie.director = Director.find_or_create_by(name: params[:director])
        @actors = Actor.find_or_create_actors(params[:actors])
        @movie.actors.clear
        @movie.actors += @actors
        if @movie.save
            flash[:message] = "Successfully updated the movie."
            redirect "/movies/#{@movie.slug}"
        else
            flash[:message] = "Unable to create the movie."
            redirect '/failure'
        end
    end

    #Removing this feature for now due to safty lol
    # get '/movies/:slug/delete' do
    #     @movie = Movie.find_by_slug(params[:slug])
    #     erb :'movies/delete'
    # end

    # delete '/movies/:slug' do
    #     @movie = Movie.find_by_slug(params[:slug])
    #     Movie.delete(@movie.id)
    #     redirect '/movies'
    # end

    get '/failure' do
        erb :'movies/failure'
    end

end