class UsersController < ApplicationController
    
    configure do
        set :views, Proc.new { File.join(root, "../views/") }
        enable :sessions
        set :session_secret, "password_security"
        use Rack::Flash
    end

    get '/users/login' do
        erb :'users/login'
    end

    post '/login' do
        @user = User.find_by(username: params[:username], password: params[:password])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash[:message] = "Login approved."
            redirect '/account'
        else
            flash[:message] = "Username or Password Error"
            redirect '/failure'
        end
    end
    
    get '/account' do
        if Helpers.logged_in?
            erb :account
        else
            flash[:message] = "Login to continue."
            erb :'users/login'
        end
    end

    get '/users/signup' do
        erb :'users/signup'
    end

    post '/signup' do
        debugger
        @user = User.new(username: params[:username], password: params[:password])
        if @user.save
            redirect '/users/login'
        else
            redirect '/failure'
        end
    end

    get '/failure' do
        erb :'users/failure'
    end

end