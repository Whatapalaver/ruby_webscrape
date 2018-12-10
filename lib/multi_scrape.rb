require 'nokogiri'
require 'open-uri'
require 'json'

class MultiScrape
  attr_reader = :base_url
  attr_accessor = :page, :music_events, :max_pages

  def initialize(base_url = 'https://www.wegottickets.com/searchresults/page/' )
    @base_url = base_url
    @music_events = []
    @page = scrape(@base_url + '1/all#paginate')
    @max_pages = parse_maxpage_links()
  end

  def multiparser
    # switch counter lines for all or a test scrape of 25 pages only
    for counter in 1..25
    # for counter in 1..@max_pages
      url = @base_url + counter.to_s + '/all#paginate'
      puts url
      scrape(url)
      parse
    end
    print_json()
  end

  def scrape(url)
    @page = Nokogiri::HTML(open(url))
  end

  def parse
    events_document(@page).each do |event|
      @music_events.push(
        artists: artists(event),
        city: city(event),
        venue: venue(event),
        date: date(event),
        price: price(event)
      )
    end
    return @music_events
  end

  def parse_maxpage_links
    pages = []
    pagination_document(@page).each do |page_link|
      pages.push(page_link.text)
    end
    return pages.pop.to_i
  end

  def print_json
    json = JSON.pretty_generate(@music_events)
    File.open("multi_music.json", 'w') { |file| file.write(json) }
    return json
  end

  private

  # Pagnination methods

  def pagination_document(page)
    page.css('div#paginate div.block-group.advance-filled.section-margins.padded.text-center a.pagination_link')
  end

  # Events methods

  def events_document(page)
    page.css('div.content.block-group.chatterbox-margin')
  end

  def artists(event)
    event.css('a.event_link').text
  end

  def city(event)
    location_array = event.css('div.venue-details h4')[0].text.split(':')
    location_array[0]
  end

  def venue(event)
    location_array = event.css('div.venue-details h4')[0].text.split(':')
    location_array[1]&.strip
  end

  def date(event)
    event.css('div.venue-details h4')[1].text
  end

  def price(event)
    
  end
end
