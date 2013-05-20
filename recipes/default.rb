package 'redis-server'

package 'ruby1.9.3'

package 'libxml2'

package 'libxml2-dev'

package 'libxslt1.1'

package 'libxslt1-dev'

package 'graphicsmagick'

package 'poppler-utils'

package 'poppler-data'

package 'ghostscript'

package 'tesseract-ocr'

package 'pdftk'

package 'libreoffice'

package 'wget'

script "bundle install" do
  interpreter "bash"
  user "root"
  cwd "/vagrant"
  code %Q{
    update-alternatives --set ruby /usr/bin/ruby1.9.3
    gem install bundle
    gem install debugger
    bundle install
  }
end

bash "setup" do
  user 'root'
  cwd '/vagrant'
  code  <<-EOH
    QUEUE=name_finder rake resque:work &
  EOH
end
