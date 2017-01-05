# Basic API Usage and Quick Start

## Example

Here's the output of a topic summary request for ["unix"](http://api.duckduckgo.com/?q=unix&o=json&pretty=1), there is a huge amount of extra noise.

Now with automatic relevant data handling with `handle()`, we can extract the information
we want. Here's how:
```Ruby
require 'yaml'
require 'duckgo'
include DuckGo

result = handle("unix")
puts result.to_yaml
```

And this is the *now filtered* result:

```YAML
---
Heading: Unix
Entity: os
Type: Article
Description: Unix is a family of multitasking, multiuser computer operating systems
  that derive from the original AT&T Unix, developed starting in the 1970s at the
  Bell Labs research center by Ken Thompson, Dennis Ritchie, and others.
Further Reading: https://en.wikipedia.org/wiki/Unix
Related:
- Unix Category
- Market share of operating systems - The usage share of operating systems is the
[...]

Infobox:
  Company / developer: Ken Thompson, Dennis Ritchie, Brian Kernighan, Douglas McIlroy,
    and Joe Ossanna at Bell Labs
  Written in: C and assembly language
[...]

Results:
  Official site: http://unix.org
```
