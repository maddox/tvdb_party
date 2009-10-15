require 'test_helper'

class TvdbPartyTest < Test::Unit::TestCase
  context "tvdb search" do
  
    context "search for terrible query" do
      setup do
        tvdb = TvdbParty::Search.new('A97A9243F8030477')
        @results = tvdb.search("sdfsafsdfds")
      end
      
      should "have 0 results" do
        puts @results.inspect
        assert_equal 0, @results.size
      end

    end
  
  end
end
