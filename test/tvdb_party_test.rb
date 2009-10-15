require 'test_helper'

class TvdbPartyTest < Test::Unit::TestCase
  context "tvdb search" do
    setup do 
      @tvdb = TvdbParty::Search.new('A97A9243F8030477')
    end
  
    context "search for terrible query" do
      setup do
        @results = @tvdb.search("sdfsafsdfds")
      end
      
      should "have 0 results" do
        assert_equal 0, @results.size
      end

    end

    context "search for real show" do
      setup do
        @results = @tvdb.search("jojos")
      end
      
      should "have 0 results" do
        assert_equal 2, @results.size
      end
      
      context "get the series" do
        setup do 
          @series = @tvdb.get_series_by_id(@results.first['seriesid'])
        end
        
        should "have a series" do
          assert_equal TvdbParty::Series, @series.class
        end

      end

    end
  
  end
end
