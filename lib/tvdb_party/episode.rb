module TvdbParty
  class Episode
    attr_reader :client
    attr_accessor :id, :imdb_id, :season_number, :number, :name, :overview, :air_date, :thumb, :guest_stars, :director, :writer
    
    def initialize(client, options={})
      @client = client
      @id = options["id"]
      @imdb_id = options["IMDB_ID"]
      @season_number = options["SeasonNumber"]
      @number = options["EpisodeNumber"]
      @name = options["EpisodeName"]
      @overview = options["Overview"]
      @thumb = "http://thetvdb.com/banners/" + options["filename"] if options["filename"].to_s != ""
      @director = options["Director"]
      @writer = options["Writer"]
      @series_id = options["seriesid"]
      if options["GuestStars"]
        @guest_stars = options["GuestStars"][1..-1].split("|")
      else
        @guest_stars = []
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
