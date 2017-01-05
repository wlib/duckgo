#!/usr/bin/env ruby
# Daniel Ethridge

require 'uri'
require 'open-uri'
require 'json'
require 'yaml'

module DuckGo
  # Do a raw api request based on paramaters
  def get(params, path="/", domain="https://api.duckduckgo.com") # domain can also just be plain duckduckgo.com
    if params.nil?
      endpoint = "#{domain}/#{path}"
    else
      endpoint = "#{domain}/#{path}?#{URI.encode_www_form(params)}"
    end
    body = open(endpoint).read
    return body
  end

  # Dump the useful data straight from DuckDuckGo's API
  # If format is XML, return it as a string even if parse is true
  def get_data(keywords, format=0, no_redirect=1, parse=true)
    params = {
      "q" => keywords,
      "format" => ["json", "xml"][format],
      "no_redirect" => [0, 1][no_redirect]
    }
    keywords.split(" ").each do |word|
      if word.start_with?("!")
        puts "Warning: '!x word' syntax results in a bang redirect"
      end
    end
    body = get(params)
    if parse
      if format == 0
        return JSON.parse(body)
      else
        return body
      end
    else
      return body
    end
  end

  # Get a website/page's favicon through duckduckgo's proxy
  def get_favicon(page)
    favicon = get(nil, "/i/#{page}.ico")
    if favicon == "GIF89a\x01\x00\x01\x00\x80\x01\x00\x00\x00\x00\xFF\xFF\xFF!\xF9\x04\x01\x00\x00\x01\x00,\x00\x00\x00\x00\x01\x00\x01\x00\x00\x02\x02L\x01\x00;"
      puts "Response is 200-OK, but content is a generic response"
      return nil
    else
      return favicon
    end
  end

  # Return data describing the extra info fields
  def find_extras(data)
    extras = {}
    unless data["Infobox"].empty?
      extras["Infobox"] = {
        "Total" => data["Infobox"]["content"].length
      }
    end
    unless data["Results"].empty?
      extras["Results"] = {
        "Total" => data["Results"].length
      }
    end
    unless data["Answer"].empty?
      extras["Answer"] = {
        "Answer" => data["Answer"],
        "Type" => data["AnswerType"]
      }
    end
    unless data["Definition"].empty?
      extras["Definition"] = {
        "Definition" => data["Definition"],
        "Source" => data["DefinitionSource"],
        "URL" => data["DefinitionURL"]
      }
    end
    unless data["Redirect"].empty?
      extras["Bang Redirect"] = data["Redirect"]
    end
    return extras
  end

  # Extract extra info based on an input extras_data
  def extract_extras(data, extras_data)
    extras = {}
    if extras_data["Infobox"]
      extras["Infobox"] = extract_infobox(data)
    end
    if extras_data["Results"]
      extras["Results"] = extract_results(data)
    end
    if extras_data["Answer"]
      extras["Answer"] = extras_data["Answer"]
    end
    if extras_data["Definition"]
      extras["Definition"] = extras_data["Definition"]
    end
    if extras_data["Bang Redirect"]
      extras["Bang Redirect"] = extras_data["Bang Redirect"]
    end
    return extras
  end

  # Extract common info
  def extract_common(data)
    output = {
      "Heading" => data["Heading"],
      "Entity" => data["Entity"],
      "Type" => "",
      "Description" => data["AbstractText"],
      "Further Reading" => data["AbstractURL"],
      "Related" => []
    }
    case data["Type"]
      when "A"
        type = "Article"
      when "C"
        type = "Category"
      when "D"
        type = "Disambiguation"
      when "E"
        type = "Exclusive"
      when "N"
        type = "Name"
      else
        type = "Nothing or unknown"
    end
    output["Type"] = type
    data["RelatedTopics"].each do |topic|
      unless topic["Text"].nil?
        output["Related"] << topic["Text"]
      end
    end
    output.delete_if do |key, value|
       value.empty?
    end
    return output
  end

  # Extract results from hash
  def extract_results(data)
    output = {}
    data["Results"].each do |result|
      output[result["Text"]] = result["FirstURL"]
    end
    return output
  end

  # Extract infobox from hash
  # Official example : http://api.duckduckgo.com/?q=valley+forge+national+park&format=json&pretty=1
  def extract_infobox(data)
    output = {}
    tsums = data["Infobox"]["content"]
    tsums.each do |section|
      output[ section["label"] ] = section["value"]
    end
    return output
  end

  # Handle a common search automatically
  def handle(keywords)
    data = get_data(keywords)
    common = extract_common(data)
    extras_data = find_extras(data)
    extras = extract_extras(data, extras_data)
    result = common.merge(extras)
    puts result.to_yaml
  end
end