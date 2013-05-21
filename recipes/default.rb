package 'redis-server'

package 'apache2'

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

gem_package 'mysql'


script "gems install" do
  interpreter "bash"
  user "root"
  cwd "/vagrant"
  code %Q{
    update-alternatives --set ruby /usr/bin/ruby1.9.3
    gem install bundle
    gem install debugger
  }
end

root_connection = { :host => 'localhost', 
                :username => 'root', 
                :password => node['mysql']['server_root_password'] }

mysql_database_user node['mysql']['gnrd_user'] do
  connection root_connection
  password node['mysql']['gnrd_user_password']
  action :create
end

mysql_database_user node['mysql']['gnrd_user'] do
  connection root_connection
  host 'localhost'
  database_name 'gnrd'
  action :grant
end

mysql_database 'gnrd' do
  connection ({:host => "localhost", :username => node['mysql']['gnrd_user'], :password => node['mysql']['gnrd_user_password']})
  action :create
end

script "bundle install" do
  interpreter "bash"
  user "root"
  cwd "/vagrant"
  code %Q{
    bundle install
  }
end

script 'setup' do
  interpreter 'bash'
  user 'root'
  cwd '/vagrant'
  code  <<-EOH
    RACK_ENV=production rake migrate
    RACK_ENV=production QUEUE=name_finder rake resque:work &
  EOH
end
