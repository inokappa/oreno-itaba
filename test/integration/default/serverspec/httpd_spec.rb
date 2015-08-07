require 'serverspec'

set :backend, :exec

if os[:family] == 'redhat'

  describe package("httpd") do
    it { should be_installed }
  end
  
  describe service("httpd") do
    it { should be_enabled }
    it { should be_running }
  end

elsif ['debian', 'ubuntu'].include?(os[:family])

  describe package("apache2") do
    it { should be_installed }
  end

  describe service("apache2") do
    it { should be_enabled }
    it { should be_running }
  end

end
