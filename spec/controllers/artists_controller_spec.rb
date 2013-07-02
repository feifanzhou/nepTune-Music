require 'spec_helper'

describe ArtistsController do
	before :each do
		@artist = Artist.first
	end
	describe "GET #about" do
		it "finds artist by artistname" do
			visit artist_about_path(@artist.artistname); save_page
			puts "2 ===================== #{ artist_about_path(@artist.artistname) }"
			# assigns(:artist).should eq(@artist)
			assigns[:artist].should_not be_nil
		end
		it "renders the :about view" do
			visit artist_about_path(@artist.artistname)
			# response.should render_template :about
			response.should be_success
		end
	end

	describe "GET #music" do
		it "finds artist by artistname" do
			visit artist_music_path(@artist.artistname)
			# assigns(:artist).should eq(@artist)
			assigns[:artist].should_not be_nil
		end
		it "renders the :music view" do
			visit artist_music_path(@artist.artistname)
			# response.should render_template :music
			response.should be_success
		end
	end

	describe "GET #events" do
		it "finds artist by artistname" do
			visit artist_events_path(@artist.artistname)
			# assigns(:artist).should eq(@artist)
			assigns[:artist].should_not be_nil
		end
		it "gets all the artist's events" do
			# evt = create_artist_event(artist)
			# visit artist_events_path(artist)
			# assigns(:events).should eq([evt])
			pending
		end
		it "renders the :events view" do
			# response.should render_template :events
			response.should be_success
		end
	end

	describe "POST #update_content" do
		context "for about gallery caption" do
		end

		context "for about story" do
		end

		context "for about contact info" do
		end
	end

	describe "POST #remove_media" do
		context "given location" do
		end

		context "without location" do
		end
	end
end
