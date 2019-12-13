class Director < ActiveRecord::Base
    has_many :movies

    def slug
        self.name.split.map { |part| part.downcase }.join("-")
    end

    def self.find_by_slug(slug)
        unslugifed = slug.split("-").map { |part| part.capitalize }.join(" ")
        self.find_by_name(unslugifed)
    end

end