#
# Cookbook Name:: mailcatcher
# Recipe:: default
#
# Copyright 2013, Bryan te Beek
# This version Copyright 2014-2015, George Papadopoulos
#

# This is a dependency of MailCatcher
case node['platform_family']
    when "debian"
        package "sqlite"
        package "libsqlite3-dev"
    when "rhel", "fedora", "suse"
        package "libsqlite3-dev"
end

gem_package "i18n" do
    version "0.6.11"
end

# Install MailCatcher
gem_package "mailcatcher" do
    # Pin to this version - later versions produces a confict with i18n
    version "0.5.12"
end

# Create service file
template "/etc/init.d/mailcatcher" do
    source "mailcatcher.service.erb"
    owner "root"
    group "root"
    mode "0755"
    action :create
end

bash "install_mailcatcher_service" do
    user "root"
    code "update-rc.d mailcatcher defaults 99 01"
end
