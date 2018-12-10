require 'nokogiri'
require 'open-uri'
require 'json'

class Scrape

  attr_accessor = :url, :page, :music_events

  def initialize(url = 'https://www.wegottickets.com/searchresults/all' )
    @url  = url
    @page = scrape
    @music_events = []
  end

  def scrape
    Nokogiri::HTML(open(@url))
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

  def print_json
    parse
    json = JSON.pretty_generate(@music_events)
    File.open("events.json", "w") { |file| file.write(json) }
    return json
  end

  private

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
