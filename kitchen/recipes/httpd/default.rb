case node[:platform]
when "ubuntu", "debian"
  package "apache2"
  service "apache2" do
    action [ :start, :enable ]
  end
when "centos", "redhat", "amazon"
  package "httpd"
  service "httpd" do
    action [ :start, :enable ]
  end
end
