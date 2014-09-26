gnrd Cookbook
===========
Installs [Global Names Recognition and Discovery][1] service and sets up its 
name recognition engines

Requirements
------------
### Cookbooks

Requires following cookbooks:

- taxon-finder - heuristic scientific name finder
- NetiNeti - natural language processing name finder

### Platforms
The following platforms are supported and tested under test kitchen:

- Ubuntu 14.04

Attributes
----------

### default

- `node['gnrd']['dir']` - Location of the gnrd source
- `node['gnrd']['log_dir']` - Location of logfiles
- `node['rescue-workers-count']` - Number of workers running in parallel

Recipes
-------

- `default.rb` - Installs and configures GNRD, NetiNeti, TaxonFinder

License & Authors
-----------------
- Author:: Dmitry Mozzherin[2]

Copyright 2014, [Marine Biological Laboratory][3] MIT License


[1]: https://github.com/GlobalNamesArchitecture/gnrd
[2]: https://github.com/dimus
[3]: http://mbl.edu
