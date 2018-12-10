require 'scrape'

RSpec.describe Scrape do
  before(:each) do

    @expected_array = [{
      :artists=>"GELLERT SPA FULL DAY ENTRANCE TICKET",
      :city=>"BUDAPEST",
      :date=>"Tue 6th Nov, 2018, 9:00am",
      :price=>nil,
      :venue=>"Gellert Thermal Spa"
    },
      {
      :artists=>"SZECHENYI SPA FULL DAY ENTRANCE TICKET",
      :city=>"BUDAPEST",
      :date=>"Tue 6th Nov, 2018, 9:00am",
      :price=>nil,
      :venue=>"Szechenyi Thermal Spa"
    }]

    @expected_json = @expected_array.to_json

    @test_scrape = Scrape.new('test.html')
  end

  it "returns a scrape" do
    expect(@test_scrape.to_s).to match(/Scrape/)
  end

  describe '.parse' do
    it "can parse an html document" do
      expect(@test_scrape.parse.length).to be > 0
    end

    it "can parse an html document and include artists" do
      expect(@test_scrape.parse.to_s).to match(/artists/)
    end

    it "can parse an html document and include city" do
      expect(@test_scrape.parse.to_s).to match(/city/)
    end

    it "can parse an html document and provide the expected output" do
      expect(@test_scrape.parse).to match(@expected_array)
    end
  end

  describe '.print_json' do
    # This prevents the test runner overwriting our json output file
    let(:content) { StringIO.new("1\n2\n3") }

    specify do
      allow(File).to receive(:open).and_yield(content)
      expect(@test_scrape.print_json).to match(@expected_json)
    end
  end

end
