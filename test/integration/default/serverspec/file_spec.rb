require 'serverspec'

set :backend, :exec

files = ['/tmp/file01', '/tmp/file02']

files.each do |file|
  describe file file do
    it { should be_file }
    its(:content) { should match /Hello itamae/ }
  end
end
