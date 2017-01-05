# Getting Data

## get()

`get()` is the function used to recieve data from any page with any paramaters on any site,
but by default knows to just call duckduckgo's api with a paramater hash as the first argument.

### Arguments

`get(params, path="/", domain="https://api.duckduckgo.com")`

+ `params`
  - A hash with query paramaters
+ `path`
  - The endpoint path
+ `domain`
  - The domain of the website called

### Usage

```Ruby
duckduckgo = {
  "q" => "search string",
  "format" => "json"
}

wikipedia = {
  "action" => "opensearch",
  "search" => "wiki"
}

puts get(duckduckgo) #=> "{"DefinitionSource":..."
puts get(wikipedia, "/w/api.php", "https://en.wikipedia.org") #=> "["wiki",["Wiki","Wikipedia","Wikimedia..."
```

## get_data()

This is a wrapper around `get()` to recieve duckduckgo's instant answers data.

### Arguments

`get_data(keywords, format=0, skip_disambig=1, no_redirect=1, parse=true)`

+ `keywords`
  - The keywords passed into the search
+ `format`
  - The returned format
    - 0 : json (default)
    - 1 : xml
+ `skip_disambig`
  - Whether or not to skip a disambiguation result
    - 0 : don't skip
    - 1 : skip (default)
+ `no_redirect`
  - If this is a [!bang redirect](https://duckduckgo.com/bang), decide if we should follow the redirect
    - 0 : follow redirect
    - 1 : don't redirect (default)
+ `parse`
  - Return a parsed hash instead of a string, only parses if format is json
    - true : return a hash (default)
    - false : return a string

### Usage

```Ruby
require 'yaml'

data = get_data("something")
puts data.to_yaml
#=> "---
# DefinitionSource: ....
```

## get_favicon()

Another wrapper that just gets a website's favicon

### Arguments

`get_favicon(page)`

+ `page`
  - The webpage or site domain to get the favicon from

### Usage

```Ruby
site = "google.com"
file = File.open("#{site}-favicon.ico", "w")
favicon = get_favicon(site)
file.write(favicon)
file.close
```