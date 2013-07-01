require 'spec_helper'

describe ArtistsController do
	describe "GET artist nav sections" do
		it "finds artist by artistname" do
			artist = Factory(:artist)
			get :about
			assigns(:artist).should eq(artist)
			get :music
			assigns(:artist).should eq(artist)
			get :events
			assigns(:artist).should eq(artist)
		end
	end
	describe "GET #about" do
		it "renders the :about view" do
			get :about
			response.should render_template :about
		end
	end

	describe "GET #music" do
		it "renders the :music view" do
			get :music
			response.should render_template :music
		end
	end

	describe "GET #events" do
		it "gets all the artist's events"
		it "renders the :events view"
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
