module TvdbParty
  class Episode
    attr_reader :client
    attr_accessor :id, :season_number, :number, :name, :overview, :air_date, :thumb, :guest_stars, :director, :writer，:imdb_id
                  :rating,:ratingcount
    
    def initialize(client, options={})
      @client = client
      @id = options["id"]
      @season_number = options["SeasonNumber"]
      @number = options["EpisodeNumber"]
      @name = options["EpisodeName"]
      @overview = options["Overview"]
      @thumb = "http://thetvdb.com/banners/" + options["filename"] if options["filename"].to_s != ""
      @director = options["Director"]
      @writer = options["Writer"]
      @series_id = options["seriesid"]
      @imdb_id = options["IMDB_ID"]
      if options["GuestStars"]
        @guest_stars = options["GuestStars"].split("|").reject(&:empty?)
      else
        @guest_stars = []
      end

      begin 
        @air_date = Date.parse(options["FirstAired"])
      rescue
        puts 'invalid date'
      end
    end

    if options["Rating"] && options["Rating"].size > 0
        @rating = options["Rating"].to_f
      else
        @rating = 0
      end

      if options["RatingCount"] && options["RatingCount"].size > 0
        @ratingcount = options["RatingCount"].to_f
      else
        @ratingcount = 0
      end
    
    def series
      client.get_series_by_id(@series_id)
    end
  end
end