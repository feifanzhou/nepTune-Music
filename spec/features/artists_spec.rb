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
      it { should have_selector(".AddVideoURL") }

      describe "check it has proper media" do
        it "should have all media" do
          @artist.media_for_location(:AboutGallery).each do |m|
            page.html.should include(m.show_html)
          end
        end
      end

      describe "add image", js: true do
        before do
          find('#addImage').find(".AddElementFace").click
          find('#selectImageButton').set(File.join(Rails.root, '/test_files/meditate.jpg'))
          fill_in "Caption for this picture", with: "Cool gnu"
        end

        it "should add to database" do
          gallery_count = @artist.media_for_location(:AboutGallery).count
          media_count = @artist.media.count
          click_button "Save Image"
          @artist.media_for_location(:AboutGallery).count should == (gallery_count+1)
          @artist.media.count.should == (media_count+1)
        end


        describe "should be there" do
          before do
            find('#selectImageButton').set(File.join(Rails.root, '/test_files/meditate.jpg'))
            fill_in "Caption for this picture", with: "Yokolowakawaka"
            click_button "Save Image"
          end

          it "and deletable" do
            gallery_count = @artist.media_for_location(:AboutGallery).count
            media_count = @artist.media.count

            page.should have_content('Yokolowakawaka')

            find('#slider').find(".SliderElementCurrent").find(".SliderElementRemoveOverlay").click

            page.should_not have_content('Yokolowakawaka')

            @artist.media_for_location(:AboutGallery).count should == (gallery_count-1)
            @artist.media.count.should == (media_count-1)
          end

        end
      end

      describe "add video", js: true do
        before do
          find('#addVideo').find(".AddElementFace").click
          fill_in "Video URL", with: 'http://www.youtube.com/watch?v=m3I2r0viGyA'
          fill_in "Caption for this video", with: "WHITE REFLECTION!!!"
        end

        it "should add to database" do
          gallery_count = @artist.media_for_location(:AboutGallery).count
          media_count = @artist.media.count
          click_button "Save Video"
          @artist.media_for_location(:AboutGallery).count should == (gallery_count+1)
          @artist.media.count.should == (media_count+1)
        end

        # tests are consolidated here because javascript takes forever to run =/

        describe "should be there" do
          before do
            fill_in "Video URL", with: 'http://www.youtube.com/watch?v=XLgYAHHkPFs'
            fill_in "Caption for this video", with: "Imagine -- John Lennon"
            click_button "Save Video"
          end

          it "and deletable" do
            gallery_count = @artist.media_for_location(:AboutGallery).count
            media_count = @artist.media.count

            page.should have_content('Imagine -- John Lennon')

            find('#slider').find(".SliderElementCurrent").find(".SliderElementRemoveOverlay").click

            page.should_not have_content('Imagine -- John Lennon')

            @artist.media_for_location(:AboutGallery).count should == (gallery_count-1)
            @artist.media.count.should == (media_count-1)
          end

        end
      end

    end

    describe "invalid user" do
    end

  end


end
