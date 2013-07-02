require 'spec_helper'

describe ArtistsController do
	let(:artist) { FactoryGirl.create(:artist) }
	describe "GET #about" do
		it "renders the :about view" do
			visit artist_about_path(artist.artistname)
			# response.should render_template :about
			response.should be_success
		end
	end

	describe "GET #music" do
		it "renders the :music view" do
			visit artist_music_path(artist.artistname)
			# response.should render_template :music
			response.should be_success
		end
	end

	describe "GET #events" do
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
