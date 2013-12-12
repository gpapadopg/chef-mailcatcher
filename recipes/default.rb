#
# Cookbook Name:: mailcatcher
# Recipe:: default
#
# Copyright 2013, Bryan te Beek
#

# This is a dependency of MailCatcher
case node['platform_family']
    when "debian"
        package "sqlite"
        package "libsqlite3-dev"
    when "rhel", "fedora", "suse"
        package "libsqlite3-dev"
end

# Install MailCatcher
gem_package "mailcatcher"

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
    code "update-rc.d mailcatcher defaults 98 02"
end

# Generate the command
#command = ["mailcatcher"]
#command << "--http-ip #{node['mailcatcher']['http-ip']}"
#command << "--http-port #{node['mailcatcher']['http-port']}"
#command << "--smtp-ip #{node['mailcatcher']['smtp-ip']}"
#command << "--smtp-port #{node['mailcatcher']['smtp-port']}"
#command = command.join(" ")

# Start MailCatcher
#bash "mailcatcher" do
#    not_if "ps ax | grep -E 'mailcatche[r]'"
#    code command
#end
