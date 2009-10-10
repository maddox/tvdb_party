module TvdbParty
  class Search
    include HTTParty
    base_uri 'www.thetvdb.com/api'

    def initialize(the_api_key)
      @api_key = the_api_key
    end
    
    def search(series_name)
      response = self.class.get("/GetSeries.php", {:query => {:seriesname => series_name}})
      response["Data"]["Series"]
      case response["Data"]["Series"]
      when Array
        response["Data"]["Series"]
      when Hash
        [response["Data"]["Series"]]
      end
    end

    def get_series_by_id(series_id)
      response = self.class.get("/#{@api_key}/series/#{series_id}/en.xml")
      if response["Data"] && response["Data"]["Series"]
        Series.new(self, response["Data"]["Series"])
      else
        nil
      end
    end
    
    def get_episode(series, season_number, episode_number)
      response = self.class.get("/#{@api_key}/series/#{series.id}/default/#{season_number}/#{episode_number}/en.xml")
      if response["Data"] && response["Data"]["Episode"]
        Episode.new(response["Data"]["Episode"])
      else
        nil
      end
    end

    def get_banners(series)
      response = self.class.get("/#{@api_key}/series/#{series.id}/banners.xml")
      return [] unless response["Banners"] && response["Banners"]["Banner"]
      case response["Banners"]["Banner"]
      when Array
        response["Banners"]["Banner"].map{|result| Banner.new(result)}
      when Hash
        [Banner.new(response["Banners"]["Banner"])]
      else
        []
      end
    end

  end
end