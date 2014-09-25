# apache_module "proxy"
#
# apache_module "proxy_balancer"
#
# apache_module "proxy_http"
#
# apache_module "rewrite"
#
# directory "/etc/thin" do
#   owner "root"
#   group "root"
#   mode "0755"
#   action :create
# end
#
# template "/vagrant/config.yml" do
#   source "db_config.erb"
#   mode "0644"
#   owner "root"
#   group "root"
# end
#
# template "/etc/apache2/sites-available/default" do
#   source "apache_default_site.erb"
#   mode "0644"
#   owner "root"
#   group "root"
# end
#
# link "/etc/apache2/sites-enabled/000-default" do
#   to "/etc/apache2/sites-available/default"
# end
#
# template "/etc/thin/gnrd.yml" do
#   source "thin_config.erb"
#   mode "0644"
#   owner "root"
#   group "root"
# end
#
# template "/etc/init.d/thin" do
#   source "thin_daemon.erb"
#   mode "0755"
#   owner "root"
#   group "root"
# end
log "Updating distro" do
  level :info
end

script "distro upgrade" do
  interpreter "bash"
  user "root"
  code %(
   apt-get update
   apt-get -q -y dist-upgrade
  )
end

log "setting up server name" do
  level :info
end

script "setting hostname" do
  interpreter "bash"
  user "root"
  code "echo #{node[:gnrd][:server_name]} > /etc/hostname"
end

%w(git nginx mysql-server redis-server libxml2 libxml2-dev libxslt1.1
   libxslt1-dev graphicsmagick graphicsmagick poppler-utils poppler-data
   ghostscript tesseract-ocr pdftk libreoffice wget).each do |package_name|

  package package_name do
    options "--fix-missing" if package_name.match(/poppler/)
  end

end

log "setting up system-wide rvm" do
  level :info
end

script "installing rvm" do
  interpreter "bash"
  user "vagrant"
  code %(
    \\curl -sSL https://get.rvm.io | sudo bash -s stable"
    sudo sed -i.bak "s/^rvm:.:.*:$/\0vagrant/" /etc/group
  )
  not_if { "which rvm | grep rvm" }
end

script "set ruby" do
  user "vagrant"
  code %(
    cd /vagrant
    rvm install `cat .ruby-version`
  )
  not_if { "rvm list |grep `cat .ruby-version`" }
end

# script "run vagrant_setup script" do
#   user "vagrant"
#   code %Q(
#     cd /vagrant
#     ./script/vagrant_setup
#   )
#   not_if { File.exist? \\vagrant\\src }
# end

# script "bundle install" do
#   interpreter "bash"
#   user "root"
#   code %Q{
#     gem install bundle
#   }
#   not_if { "gem list | grep bundle" }
# end

# root_connection = { :host => "localhost",
#                     :username => "root",
#                     :password => node["mysql"]["server_root_password"] }
#
# gnrd_connection = { :host => "localhost",
#                     :username => node["mysql"]["gnrd_user"],
#                     :password => node["mysql"]["gnrd_user_password"]}
#
# mysql_database_user node["mysql"]["gnrd_user"] do
#   connection root_connection
#   password node["mysql"]["gnrd_user_password"]
#   action :create
# end
#
# mysql_database_user node["mysql"]["gnrd_user"] do
#   connection root_connection
#   host "localhost"
#   database_name "gnrd"
#   action :grant
# end
#
# mysql_database "gnrd" do
#   connection gnrd_connection
#   action :create
# end
#
# # script "global system upgrade" do
# #   interpreter "bash"
# #   user "root"
# #   code "apt-get -q -y dist-upgrade"
# # end
# #
# # script "bundle install" do
# #   interpreter "bash"
# #   user "root"
# #   cwd "/vagrant"
# #   code %Q{
# #     bundle install --without development
# #   }
# # end
#
# script "setup" do
#   interpreter "bash"
#   user "root"
#   cwd "/vagrant"
#   code  <<-EOH
#     source /etc/profile
#     bundle install --without development
#     rake db:create:all
#     rake db:migrate
#     RACK_ENV=test rake db:migrate
#     RACK_ENV=production rake db:migrate
#   EOH
# end
#
# service "thin" do
#   action :restart
# end
#
# template "/etc/init/gnrd_worker.conf" do
#   owner "root"
#   group "root"
#   mode "0644"
#   source "gnrd_worker.conf.erb"
# end
#
# service "gnrd_worker" do
#   provider Chef::Provider::Service::Upstart
#   supports :status => true, :start => true, :restart => true
#   action [:enable, :restart]
# end
