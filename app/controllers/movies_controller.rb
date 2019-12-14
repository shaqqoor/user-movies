class MoviesController < ApplicationController

    get '/movies' do
        @movies = Movie.all
        erb :'/movies/index'
    end

    get '/movies/new' do
        erb :'movies/new'
    end

    get '/movies/:slug' do
        @movie = Movie.find_by_slug(params[:slug])
        erb :'movies/show'
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
        @movie = Movie.find_by_slug(params[:slug])
        erb :'movies/edit'
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

    get '/movies/:slug/delete' do
        @movie = Movie.find_by_slug(params[:slug])
        erb :'movies/delete'
    end

    delete '/movies/:slug' do
        @movie = Movie.find_by_slug(params[:slug])
        Movie.delete(@movie.id)
        redirect '/movies'
    end

    get '/failure' do
        erb :'movies/failure'
    end

end