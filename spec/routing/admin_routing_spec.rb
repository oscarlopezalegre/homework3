require "rails_helper"

RSpec.describe "routes for login", :type => :routing do
  it "routes login to the sessions/create controller" do
    expect(post("login")).
      to route_to(:controller => "sessions", :action => "create")
  end

  it "routes logout to the sessions/destroy controller" do
    expect(get("logout")).
      to route_to(:controller => "sessions", :action => "destroy")
  end

end