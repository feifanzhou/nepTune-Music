# require 'spec_helper'

# describe "Static pages" do
#   subject { page }
  
#   describe "Home page" do
#     before { visit root_path }
#     it { should have_selector('title', text: "nepTune Music") }
    
#     it { should have_selector('div', id: "signup") }
#     it { should have_selector('h1', id: "heroTagline") }
#     it { should have_selector('p', id: "heroBlurb") }
    
#     describe "signup" do
#       let(:submit) { "Join" }
      
#       describe "with blank information" do
#         it "should not create a user" do
#           expect { click_button submit }.not_to change(User, :count)
#         end
#       end
#       describe "with valid information" do
#         before do
#           fill_in 'user_fname', with: "John"
#           fill_in 'user_lname', with: "Smith"
#           fill_in 'user_email', with: 'john@example.com'
#         end
#         it "should create a user" do
#           expect { click_button submit }.to change(User, :count).by(1)
#         end
#       end
#     end
    
#     it { should have_selector('div', id: "marketplace") }
#     it { should have_selector('div', id: "artists") }
#     it { should have_selector('div', id: "consumers") }
#     it { should have_selector('div', id: "partners") }
    
#     it { should have_selector('footer') }
#     ["Marketplace", "For artists", "For consumers", "Our mission", "Our team", "Press and news", "Facebook", "Twitter", "Careers", "Help and contact", "Beta access", "Terms"].each do |t|
#       it { should have_selector('a', text: t) }
#     end
#   end
# end
