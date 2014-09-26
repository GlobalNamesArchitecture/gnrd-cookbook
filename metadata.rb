name "gnrd"
maintainer "Dmitry Mozzherin"
maintainer_email "dmozzherin@gmail.com"
license "MIT"
description "configures GNRD server"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version "0.0.1"

recipe "gnrd", "configures Global Names Recognition and Discovery server"

[ubuntu].each do |os|
  supports os
end
