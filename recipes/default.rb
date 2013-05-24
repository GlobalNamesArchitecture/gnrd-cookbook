apache_module 'proxy'

apache_module 'proxy_balancer'

apache_module 'proxy_http'

apache_module 'rewrite'

directory '/etc/thin' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/vagrant/config.yml' do
  source 'db_config.erb'
  mode '0644'
  owner 'root'
  group 'root'
end

template '/etc/apache2/sites-available/default' do
  source 'apache_default_site.erb'
  mode '0644'
  owner 'root'
  group 'root'
end

link '/etc/apache2/sites-enabled/000-default' do
  to '/etc/apache2/sites-available/default'
end

template '/etc/thin/gnrd.yml' do
  source 'thin_config.erb'
  mode '0644'
  owner 'root'
  group 'root'
end

template '/etc/init.d/thin' do
  source 'thin_daemon.erb'
  mode '0755'
  owner 'root'
  group 'root'
end

package 'redis-server'

package 'apache2'

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


# script "bundle install" do
#   interpreter "bash"
#   user "root"
#   code %Q{
#     gem install bundle
#   }
#   not_if { "gem list | grep bundle" }
# end

root_connection = { :host => 'localhost', 
                    :username => 'root', 
                    :password => node['mysql']['server_root_password'] }

gnrd_connection = { :host => "localhost", 
                    :username => node['mysql']['gnrd_user'], 
                    :password => node['mysql']['gnrd_user_password']}

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
  connection gnrd_connection
  action :create
end

# script 'global system upgrade' do
#   interpreter 'bash'
#   user 'root'
#   code 'apt-get -q -y dist-upgrade'
# end
# 
# script "bundle install" do
#   interpreter "bash"
#   user "root"
#   cwd "/vagrant"
#   code %Q{
#     bundle install --without development
#   }
# end

script 'setup' do
  interpreter 'bash'
  user 'root'
  cwd '/vagrant'
  code  <<-EOH
    source /etc/profile
    bundle install --without development
    rake db:create:all
    rake db:migrate
    RACK_ENV=test rake db:migrate
    RACK_ENV=production rake db:migrate
  EOH
end

service 'thin' do
  action :restart
end

template '/etc/init/gnrd_worker.conf' do
  owner 'root'
  group 'root'
  mode '0644'
  source 'gnrd_worker.conf.erb'
end

service 'gnrd_worker' do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :start => true, :restart => true
  action [:enable, :restart]
end

