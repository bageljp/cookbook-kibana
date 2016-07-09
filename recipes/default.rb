#
# Cookbook Name:: kibana
# Recipe:: default
#
# Copyright 2014, bageljp
#
# All rights reserved - Do Not Redistribute
#

remote_file "/usr/local/src/#{node['kibana']['src']['file']}" do
  owner "root"
  group "root"
  mode 00644
  source "#{node['kibana']['src']['url']}"
end

bash "setup kibana" do
  user "root"
  group "root"
  cwd "/usr/local/src"
  code <<-EOC
    rm -rf kibana-#{node['kibana']['version']}
    gzip -dc #{node['kibana']['src']['file']} | tar xf -
    rm -rf #{node['kibana']['root_dir']}/kibana-#{node['kibana']['version']}
    mv kibana-#{node['kibana']['version']} #{node['kibana']['root_dir']}
    [ -d #{node['kibana']['link_dir']} ] || mkdir -p #{node['kibana']['link_dir']}
    cd #{node['kibana']['link_dir']}
    ln -sf #{node['kibana']['root_dir']}/kibana-#{node['kibana']['version']} kibana
  EOC
  not_if "[ -f #{node['kibana']['root_dir']}/kibana-#{node['kibana']['version']}/index.html -a -L #{node['kibana']['link_dir']}/kibana ]"
end

%w(
  config.js
).each do |t|
  template "#{node['kibana']['root_dir']}/kibana-#{node['kibana']['version']}/#{t}" do
    owner "root"
    group "root"
    mode 00664
  end
end

