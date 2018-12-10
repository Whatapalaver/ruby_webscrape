A Web Scraping Tech Test
====

Instructions
----

Write software that scrapes concert information from the pages on [this site](http://www.wegotickets.com/searchresults/all) and outputs the data in a machine readable format of your choice (e.g. JSON, XML, CSV etc.).

Each event also has its own page, which is linked to from the event titles in the above. Your script should attempt to identify:

- [x] the artists playing
- [x] the city
- [x] the name of the venue
- [x] the date
- [ ] the price

MAXIMUM 2 HOURS!!

*My Approach:*
With so little time for the challenge I opted for Ruby over Node.js in this instance as I was more comfortable with RSpec for testing. 

- I have succeeded in scraping the first page using a TDD approach and have achieved 100% test coverage.
- I have also managed to loop through all pages to create a list of all available tickets. I have not mocked the tests here so have only included a single test to demonstrate that the maximum page can be read.


*Issues:*
Testing - I ran into immediate problems trying to mock the nokogiri call and in the end opted to test the whole scrape process with a test html document that was based on two event details.

The ticket results are spread over multiple pages so I needed to extract the maximum page number with a pagination scrape and then loop through each page. While this works (manually tested to page 25 of 532 pages) I have not had chance to set up some mock tests to demonstrate it looping through multiple documents. I have a test but it runs an actual http request and obviously the number of pages returned changes. I have therefore adjusted the test to a safe > 200 pages until I can mock this. I have prepared a multitest.html file with the pagination in place but need to stub the call which concatenates the base url with an extension for the page.

Coverage - This is 100% for the single page Scrape.  
It is less than 100% for the Multi Page Scrape. The multiscrape is pretty much a duplication of the single page demonstration so I haven't duplicated the tests. The only new feature here is the page looping.

*Next Steps:*

- [ ] Price - this is only available on the individual event pages.
- [ ] Music only - fathom out how to utilise the filter for Music - General (perhaps using Capybara for form choices or Mechanize)
- [ ] Multiple pages testing - set up some mock test pages.
- [ ] Single responsibility principle - I have included all of my methods under one class. these should really be split into Scrape, Parse, Display.

How To Use
---

- Create a local clone of this project
- Change into the directory `cd ruby_webscrape`
- Install dependencies `bundle install`

IRB Instructions to generate JSON output for a single page
----

```
require './lib/scrape.rb'
temp = Scrape.new
temp.print_json
```

IRB Instructions to generate JSON output for a multiple pages
----

```
require './lib/multi_scrape.rb'
multi = MultiScrape.new
multi.multiparser
```

To test:

- This command will run both the rspec tests and simplecov `bundle exec rspec`
- To view the coverage detail as a webpage run `open coverage/index.html`