require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  scenario 'user logs in' do
 
	u = User.create({name: "admin",
              email: "admin@fake.com",
              password: "1234"})
	u.save

	fill_in 'session[email]', :with => 'admin@fake.com'	
    fill_in 'session[password]', :with => "1234"
    click_button 'commit'
    expect(page).to have_content("Welcome")
  end



end
