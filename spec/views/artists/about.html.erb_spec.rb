require 'spec_helper'

describe "Artist about page" do
	before { artist = Factory(:artist) }
	subject { artist }

	before { visit artist_about_path(artist) }
	it { should have_selector('h2', content: 'Our Story') }
	it { should have_selector('h2', content: 'Contact') }
end