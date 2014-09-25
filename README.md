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

Copyright 2014, [Marine Biological Laboratory][3]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[1][https://github.com/GlobalNamesArchitecture/gnrd]
[2][https://github.com/dimus]
[3][http://mbl.edu]
