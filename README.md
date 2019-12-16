# user-movies

README FILE

Web Application PROJECT
User login and search for movies in a database

OVERVIEW
- This project fetches a webpage from Rotten Tomatoes (https://editorial.rottentomatoes.com/guide/200-essential-movies-to-watch-now) with the top 200 movies with information on actors, directors, rating, and year. Created a local database storing all these movies. 
- I have created user, movie, actor, and director objects that represent the data fetched from that webpage and create a searachable database by the movie name.
- Users can login to thier account and view all movies/actors/directors and some movies to their list. they can also search for a spicific movie by the movie name.

HOW TO RUN PROGRAM
1. In your terminal, run 'bundle install' to install all required gems.
2. In your terminal, run 'shotgun' to start the server. 
3. Open your browser and direct to your local host port 9393

FILE INFORMATION:
- 'user-movies/app' contains MVC files
- 'user-movies/config' has the setup environment
- 'user-movies/lib' has the scraper file where I'm feeding the database from.
-'config.ru' this is the ignition of the web application where this file is require to start the web application
- Gemfile has all the required gems to run this project
-'Rakefile' helps in database and testing the application as building it.