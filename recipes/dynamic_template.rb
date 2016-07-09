#
# Cookbook Name:: kibana
# Recipe:: dynamic_template
#
# Copyright 2014, bageljp
#
# All rights reserved - Do Not Redistribute
#

package "curl"

bash "dynamic template" do
  user "root"
  group "root"
  cwd "/tmp"
  code <<-EOC
    # waiting elasticsearch running.
    sleep 20
    curl -XPUT '#{node['kibana']['elasticsearch']['uri']}/_template/logstash_template' -T /tmp/kibana_template.json
  EOC
  action :nothing
end

cookbook_file "/tmp/kibana_template.json" do
  owner "root"
  group "root"
  mode 00644
  notifies :run, resources( :bash => "dynamic template" )
end

