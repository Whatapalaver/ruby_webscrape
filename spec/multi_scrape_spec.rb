require 'multi_scrape'

RSpec.describe MultiScrape do
  before(:each) do
    @multitest_scrape = MultiScrape.new()
  end

  # This is currently making an http request and may fail if the page number changes
  # I have therefore set to be greater than some arbitrary number but I need to create a stub for the initialisation
  
  describe '.parse_maxpage_links' do
    it "identifies max pages" do
      expect(@multitest_scrape.parse_maxpage_links).to be > 200
    end

  end
end
