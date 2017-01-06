# Extracting Relevant Inforamation

Once you get the data and parse it to a hash, you need to filter for the relevant information, here's how.

## extract_common()

Extract common occuring relevant information

### Arguments

`extract_common(data)`

+ `data`
  - A hash with the data retrieved from the api (with `get_data()`)

### Usage

```Ruby
data = get_data("Hello World")
common = extract_common(data)
puts common #=> {"Heading"=>"Hello World", "Type"=>"Disambiguation"....
```

## find_extras()

This is an optional step to extract a deeper understanding of the data received.

### Arguments

`find_extras(data)`

+ `data`
  - A hash with the data retrieved from the api (with `get_data()`)

### Usage

```Ruby
data = get_data("Mark Zuckerburg")
extras_data = find_extras(data)
puts extras_data #=> {"Infobox"=>{"Total"=>13}, "Results"=>{"Total"=>1}}
```

## extract_extras()

This is how we auomatically handle extracting extra data, based off of the output of `find_extras()`

### Arguments

`extract_extras(data, extras_data)`

+ `data`
  - A hash with the data retrieved from the api (with `get_data()`)
+ `extras_data`
  - The hash we got from `find_extras()`

### Usage

```Ruby
data = get_data("Apple Inc.")
extras_data = find_extras(data)
extras = extract_extras(data, extras_data)
puts extras #=> {"Infobox"=>{"Traded as"=>"NASDAQ: aapl AAPl...}, "Results"=>{"Official Site"...
```
