require 'factory_girl'
require 'spec_helper'

# def set_host (host)
#   default_url_options[:host] = host
#   Capybara.app_host = "http://" + host
# end

# https://github.com/jnicklas/capybara
# http://stackoverflow.com/a/13755730/472768
describe "Artist pages" do
  subject { page }

  before :each do
    # set_host "beta.neptune.com:3000"
    @artist = Artist.first
  end

  describe "About page" do
    subject { page.source }
    before :each do
      visit artist_about_path(@artist.artistname)
    end
    it { should have_selector('h2', text: 'Our Story') }
    it { should have_selector('h2', text: 'Contact') }
    it { should have_selector('p', text: @artist.story) }
    it { should have_selector('#phone', text: @artist.contact_info.phone) }
    it { should have_selector('#email', text: @artist.contact_info.email) }
  end
end
