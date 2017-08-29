module TvdbParty
  class Series
    attr_reader :client
    attr_accessor :id, :name, :overview, :seasons, :first_aired, :genres, :network, :rating, :rating_count, :runtime,
                  :actors, :banners, :air_time, :imdb_id, :content_rating, :status

    def initialize(client, options={})
      @client = client
      @id = options["id"]
      @name = options["SeriesName"]
      @overview = options["Overview"]
      @network = options["Network"]
      @runtime = options["Runtime"]
      @air_time = options['Airs_Time'] if options['Airs_Time']
      @imdb_id = options["IMDB_ID"]
      @content_rating = options["ContentRating"]
      @status = options["Status"]

      if options["Genre"]
        @genres = options["Genre"][1..-1].split("|")
      else
        @genres = []
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
        @first_aired = Date.parse(options["FirstAired"])
      rescue
        puts 'invalid date'
      end
    end

    def get_episode(season_number, episode_number)
      client.get_episode(self, season_number, episode_number)
    end

    def posters(language)
      banners.select{|b| b.banner_type == 'poster' && b.language == language}
    end

    def fanart(language)
      banners.select{|b| b.banner_type == 'fanart' && b.language == language}
    end

    def series_banners(language)
      banners.select{|b| b.banner_type == 'series' && b.language == language}
    end

    def season_posters(season_number, language)
      banners.select{|b| b.banner_type == 'season' && b.banner_type2 == 'season' && b.season == season_number.to_s && b.language == language}
    end

    def seasonwide_posters(season_number, language)
      banners.select{|b| b.banner_type == 'season' && b.banner_type2 == 'seasonwide' && b.season == season_number.to_s && b.language == language}
    end

    def banners
      @banners ||= client.get_banners(self)
    end

    def seasons
      @seasons ||= client.get_seasons(self)
    end

    def episodes
      @episodes ||= client.get_all_episodes(self)
    end

    def actors
      @actors ||= client.get_actors(self)
    end

    def season(season_number)
      seasons.detect{|s| s.number == season_number}
    end

    def is_favorite?(account_id)
      client.get_favorites(account_id).include? self.id
    end

    def favorite!(account_id)
      client.add_favorite(account_id, self.id)
    end

    def unfavorite!(account_id)
      client.remove_favorite(account_id, self.id)
    end

  end
end
