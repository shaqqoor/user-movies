class Scraper
    def scrape(url = "https://editorial.rottentomatoes.com/guide/200-essential-movies-to-watch-now/")
        html = open(url)
        doc = Nokogiri::HTML(html)
        content = doc.css("div .row.countdown-item")
        content.each do |movie|
            movie_name = movie.css("div h2 a").text.strip
            movie_year = movie.css(".subtle.start-year").text.strip.split("(").join.split(")").join
            movie_rating = movie.css(".tMeterScore").text.strip
            #movie_critics = movie.css("div.info.critics-consensus").text.strip.split("Critics Consensus:").join
            #movie_synopsis = movie.css("div.info.synopsis").text.split("Synopsis:").join.split("[More]").join.strip
            movie_actors = movie.css("div.info.cast").text.strip.split("Starring:").join.strip.split(", ")
            movie_director = movie.css("div.info.director").text.strip.split("Directed By:").join.strip.split(", ").first

            movie_details = {
                :name => movie_name,
                :year => movie_year,
                :rating => movie_rating,
                #:critics => movie_critics,
                #:synopsis => movie_synopsis,
                :actors => movie_actors,
                :director => movie_director,
            }

            build_movie(movie_details)

        end
    end

    private
    def build_movie(data)
        director = Director.find_or_create_by(name: data[:director])
        movie = Movie.find_or_create_by(name: data[:name], year: data[:year], rating: data[:rating])
        movie.director = director
        data[:actors].each do |actor|
            actor = Actor.find_or_create_by(name: actor)
            movie.actors << actor
        end
        movie.save
    end
end