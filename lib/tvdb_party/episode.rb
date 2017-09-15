module TvdbParty
  class Episode
    attr_reader :client
    attr_accessor :id, :series_id, :season_number, :number, :name, :overview, :air_date, :thumb, :guest_stars, :director, :writer, :rating, :rating_count

    def initialize(client, options={})
      @client = client
      @id = options["id"]
      @season_number = options["SeasonNumber"]
      @number = options["EpisodeNumber"]
      @name = options["EpisodeName"]
      @overview = options["Overview"]
      @thumb = "https://thetvdb.com/banners/" + options["filename"] if options["filename"].to_s != ""
      @director = options["Director"]
      @writer = options["Writer"]
      @series_id = options["seriesid"]
      @rating_count = options["RatingCount"]
      if options["GuestStars"]
        @guest_stars = options["GuestStars"][1..-1].split("|")
      else
        @guest_stars = []
      end

      if options["Rating"] && options["Rating"].size > 0
        @rating = options["Rating"].to_f
      else
        @rating = 0
      end

      if options["RatingCount"] && options["RatingCount"].size > 0
        @rating_count = options["RatingCount"].to_f
      else
        @rating_count = 0
      end

      begin
        @air_date = Date.parse(options["FirstAired"])
      rescue
        puts 'invalid date'
      end
    end

    def series
      client.get_series_by_id(@series_id)
    end
  end
end
