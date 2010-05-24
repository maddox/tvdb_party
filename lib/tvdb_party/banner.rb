module TvdbParty
  class Banner
    attr_accessor :banner_type, :banner_type2, :season, :path, :thumbnail_path, :language
    
    def initialize(options={})
      @banner_type = options["BannerType"]
      @banner_type2 = options["BannerType2"]
      @season = options["Season"]
      @path = options["BannerPath"]
      @language = options["Language"]
    end
    
    def url
      "http://thetvdb.com/banners/" + @path
    end

    def thumb_url
      "http://thetvdb.com/banners/_cache/" + @path
    end

  end
end