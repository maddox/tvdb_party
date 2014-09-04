# encoding: utf-8

require 'test_helper'

class TvdbPartyTest < Test::Unit::TestCase
  context "tvdb" do
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

    context "search for episode that doesn't exist" do
      setup do
        @show = @tvdb.get_series_by_id(75700)
      end
      
      should "have handle 404 on episode query" do
        assert_equal nil, @show.get_episode(1, 17)
      end
    
    end

    context "search for real show" do
      setup do
        @results = @tvdb.search("The Office US")
      end
      
      should "have 1 results" do
        assert_equal 1, @results.size
      end
      
      context "get the series" do
        setup do 
          @series = @tvdb.get_series_by_id(@results.first['seriesid'])
        end
        
        should "have a series" do
          assert_equal TvdbParty::Series, @series.class
        end

        should "have actors" do
          assert_not_equal 0, @series.actors.size
        end

        should "have actual Actors" do
          assert_equal TvdbParty::Actor, @series.actors.first.class
        end

        should "have a first episode" do
          assert_equal "110413", @series.get_episode(1, 1).id
        end

        should "have imdb id if available" do
          assert_equal 'tt0386676', @series.imdb_id
        end

        should "have air day if available" do
          assert_equal 'Thursday', @series.air_day
        end

        should "have status if available" do
          assert_equal 'Ended', @series.status
        end

        should "have certification if available" do
          assert_equal 'TV-14', @series.certification
        end
      end
    
    end
  
  end
  context "non english series" do
    setup do
      @tvdb = TvdbParty::Search.new('A97A9243F8030477', 'de')
    end
    context "search for real show" do
      setup do
        @results = @tvdb.search("Keine Gnade für Dad")
      end

      should "have 1 results" do
        assert_equal 1, @results.size
      end
    end
  end
end
