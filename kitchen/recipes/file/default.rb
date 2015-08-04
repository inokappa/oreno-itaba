directory "/tmp/test_directory" do
  action :create
end

files = ['/tmp/file01', '/tmp/file02', '/tmp/file03']
files.each do |file|
  file file do
    action :delete
  end
end

file "/tmp/file01" do
  action :create
  mode "755"
end

file "/tmp/file01" do
  action :edit
  block do |content|
    content.gsub!("", "Hello itamae")
  end
end

file "/tmp/file02" do
  content "Hello itamae"
end
