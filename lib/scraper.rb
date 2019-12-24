class Scraper
    def scrape(url = "https://editorial.rottentomatoes.com/guide/200-essential-movies-to-watch-now/")
        html = open(url)
        doc = Nokogiri::HTML(html)
        content = doc.css("div .row.countdown-item")
        content.each do |movie|
            movie_name = movie.css("div h2 a").text.strip
            movie_year = movie.css(".subtle.start-year").text.strip.split("(").join.split(")").join
            movie_rating = movie.css(".tMeterScore").text.strip
            movie_actors = movie.css("div.info.cast").text.strip.split("Starring:").join.strip.split(", ")
            movie_director = movie.css("div.info.director").text.strip.split("Directed By:").join.strip.split(", ").first

            movie_details = {
                :name => movie_name,
                :year => movie_year,
                :rating => movie_rating,
                :actors => movie_actors,
                :director => movie_director,
            }

            build_movie(movie_details)

        end
    end

    private
    def build_movie(data)
        data[:director] ||= "Jon Favreau"
        director = Director.find_or_create_by(name: data[:director].downcase)
        movie = Movie.find_or_create_by(name: data[:name].downcase, year: data[:year], rating: data[:rating])
        movie.director = director
        movie.owned_by = 0
        data[:actors].each do |actor|
            actor = Actor.find_or_create_by(name: actor.downcase)
            movie.actors << actor if !movie.actors.include?(actor)
        end
        movie.save
    end
end