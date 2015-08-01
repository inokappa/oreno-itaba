require 'serverspec'

set :backend, :exec

describe package("sl") do
  it { should be_installed }
end
