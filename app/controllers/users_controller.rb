class UsersController < ApplicationController
    
    configure do
        set :session_secret, "password_security"
    end

    get '/users/login' do
        erb :'users/login'
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash[:message] = "Login approved."
            erb :'users/account'
        else
            flash[:message] = "Username or Password Error"
            erb :'users/failure'
        end
    end
    
    get '/users/account' do
        if Helpers.logged_in?(session)
            @user = User.find(session[:user_id])
            @movies = Movie.all
            erb :'users/account'
        else
            flash[:message] = "Login to continue."
            erb :'users/login'
        end
    end

    get '/users/signup' do
        erb :'users/signup'
    end

    post '/signup' do
        @user = User.new(username: params[:username], password: params[:password])
        if @user.save
            flash[:message] = "Thank you for signing up, login to continue."
            erb :'users/login'
        else
            flash[:message] = "Unable to signup"
            erb :'users/failure'
        end
    end

    post '/account' do
        if Helpers.logged_in?(session)
            @user = User.find(session[:user_id])
            @movie = Movie.find_by(name: params[:movie][:name].downcase)
            if @movie
                flash[:message] = "One Movie Found"
                erb :'movies/show'
            else
                flash[:message] = "Movie not Found, try again"
                erb :'users/account'
            end
        else
            flash[:message] = "Please, login to continue"
            erb :'users/failure'
        end
    end

    get '/users/logout' do
        session.clear
        redirect '/users/login'
    end

    get '/users/failure' do
        erb :'users/failure'
    end

end