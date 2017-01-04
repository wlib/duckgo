#!/usr/bin/env ruby
# Daniel Ethridge

require 'uri'
require 'open-uri'
require 'json'
require 'yaml'

module Duckgo
  # Do a raw api request based on paramaters
  def get(params, url="https://api.duckduckgo.com/?") # url can also just be plain duckduckgo.com
    endpoint = url + URI.encode_www_form(params)
    body = open(endpoint).read
    return body
  end

  # Get the data from DuckDuckGo's API
  # Paramaters used here:
  # {
  #   "q" => URI.encode_www_form(keywords),
  #   "format" => ["json", "xml"][format]
  # }
  def get_data(keywords, format=0)
  end

  # Get the bang redirect from DuckDuckGo's API
  # Paramaters used here:
  # {
  #   "q" => URI.encode_www_form("!#{bang} #{keywords}"),
  #   "format" => ["json", "xml"][format],
  #   "no_redirect" => [0, 1][no_redirect]
  # }
  def get_bang(bang, keywords, format=0, no_redirect=1)
  end

  # Get topic summaries
  # Official example : http://api.duckduckgo.com/?q=valley+forge+national+park&format=json&pretty=1
  def extract_topic_sums(data, format)
  end

  # Get categories
  # Official example : http://api.duckduckgo.com/?q=simpsons+characters&format=json&pretty=1
  def extract_categories(data, format)
  end

  # Get disambiguation
  # Official example : http://api.duckduckgo.com/?q=apple&format=json&pretty=1
  def extract_disambiguation(data, format)
  end

  # Get !bang redirect
  # Official example : http://api.duckduckgo.com/?q=!imdb+rushmore&format=json&pretty=1&no_redirect=1
  def extract_bang_redirect(data, format)
  end
end