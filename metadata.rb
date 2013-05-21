name              "gnrd"
maintainer        "Dmitry Mozzherin"
maintainer_email  "dmozzherin@gmail.com"
license           "MIT"
description       "configures gnrd"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.1"

recipe "gnrd", "configures and example gnrd server"

%w{ mysql database }.each do |cb|
  depends cb
end

%w{ ubuntu }.each do |os|
  supports os
end

