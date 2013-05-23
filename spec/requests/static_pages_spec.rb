require 'spec_helper'

describe "Static pages" do
  subject { page }
  
  describe "Home page" do
    before { visit root_path }
    it { should have_selector('title', text: "nepTune Music") }
    
    it { should have_selector('div', id: "signup") }
    it { should have_selector('h1', id: "heroTagline") }
    it { should have_selector('p', id: "heroBlurb") }
    
    it { should have_selector('div', id: "marketplace") }
    it { should have_selector('div', id: "artists") }
    it { should have_selector('div', id: "consumers") }
    it { should have_selector('div', id: "partners") }
    it { should have_selector('footer') }
  end
end
