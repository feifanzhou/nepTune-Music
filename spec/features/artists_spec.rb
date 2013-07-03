require 'factory_girl'
require 'spec_helper'

# https://github.com/jnicklas/capybara
# http://stackoverflow.com/a/13755730/472768
describe "Artist pages" do
  subject { page }

  before :all do
    @artist = Artist.first
    @user = @artist.members.first
  end

  describe "About page" do
    before :each do
      visit artist_about_path(@artist.artistname)
    end
    it { should have_selector('h2', text: 'Our Story') }
    it { should have_selector('h2', text: 'Contact') }
    it { should have_content(@artist.story) }
    it { should have_selector('#phone', text: @artist.contact_info.phone) }
    it { should have_selector('#email', text: @artist.contact_info.email) }
  end

  describe "Edit artist gallery" do
    describe "valid user" do
      before do
        sign_in_as @user, password: "foobar"
        visit artist_about_path(@artist.artistname, edit: 1)
      end

      it { should have_content("Add image") }
      it { should have_content("Add video") }
      it { should have_button("Save Image") }
      it { should have_button("Select Image") }
      it { should have_button("Save Video") }
      it { should have_button("Cancel") }

      describe "check it has proper media" do
        it "should have all media" do
          @artist.media_for_location(:AboutGallery).each do |m|
            page.html.should include(m.show_html)
          end
        end
      end

      describe "add image" do
        before do
          attach_file "Select Image", 'test_files/meditate.jpg'
          fill_in "Caption for this picture", with: "Cool gnu"
        end

        it do
          lambda do
            click_button "Save Image"
          end.should change(@artist.media_for_location(:AboutGallery), :count).by(1)
        end

        describe "should be there" do
          before do
            click_button "Save Image"
          end

          it { page.should have_content('Cool gnu') }

        end
      end

      describe "add video", :js => true do
        before do
          fill_in "Video URL", with: 'http://www.youtube.com/watch?v=m3I2r0viGyA'
          fill_in "Caption for this video", with: "WHITE REFLECTION!!!"
        end

        it do
          lambda do
            click_button "Save Video"
          end.should change(@artist.media_for_location(:AboutGallery), :count).by(1)
        end

        describe "should be there" do
          before do
            click_button "Save Video"
          end

          it { page.should have_content('WHITE REFLECTION!!!') }
        end
      end

    end

    describe "invalid user" do
    end

  end


end
