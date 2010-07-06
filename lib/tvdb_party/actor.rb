module TvdbParty
  class Actor
    attr_accessor :id, :name, :role, :image

    def initialize(options={})
      @id = options["id"]
      @name = options["Name"]
      @role = options["Role"]
      @image = options["Image"]
    end
    
    def image_url
      return nil unless @image
      "http://thetvdb.com/banners/" + @image
    end
    
  end
end
