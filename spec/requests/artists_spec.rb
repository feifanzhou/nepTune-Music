require 'factory_girl'
require 'spec_helper'

describe "Artist pages" do
	subject { page }

	before(:each) do
		@artist = FactoryGirl.create(:artist)
		contact_info = FactoryGirl.create(:contact_info)
		@artist.contact_info = contact_info
	end

	before(:each) do
		Capybara.app_host = "beta.neptune.com:3000"
	end

	describe "About page" do
		puts "====================================="
		p @artist
		before { puts artist_about_path(@artist.artistname) }
		before { visit artist_about_path(@artist.artistname); save_page }
		it { should have_selector('h2', text: 'Contact') }
		it { should have_selector('h2', text: 'Contact') }
		it { should have_selector('.ArtistStory', text: @artist.story) }
		it { should have_selector("#phone", text: @artist.contact_info.phone) }
		it { should have_selector("#email", text: @artist.contact_info.email) }
	end
end