module TvdbParty
  class Actor
    attr_accessor :id, :name, :role, :image, :sortorder

    def initialize(options={})
      @id = options["id"]
      @name = options["Name"] 
      @role = options["Role"] if options["Role"]
      @image = options["Image"] if options["Image"]
      @sortorder = options["SortOrder"] if options["SortOrder"]
    end
    
    def image_url
      return nil unless @image
      "http://thetvdb.com/banners/" + @image
    end
    
  end
end
