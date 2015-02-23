require 'spec_helper'

describe "Static pages" do
	
	describe "Home page" do

		it "should have title 'Radio Afera'" do
			visit '/static_pages/home'
			expect(page).to have_title("Radio Afera")
		end

		it "should have content 'Radio Afera'" do
			visit '/static_pages/home'
			expect(page).to have_content("Welcome")
		end
	end

	describe "Contact page" do

		it "should have title 'Radio Afera | Contact" do
			visit '/static_pages/contact'
			expect(page).to have_title("Radio Afera | Contact")
		end

		it "should have content 'Contact'" do
			visit 'static_pages/contact'
			expect(page).to have_content("Contact")
		end
	end

	describe "About page" do

		it "should have title 'Radio Afera | About" do
			visit '/static_pages/about'
			expect(page).to have_title("Radio Afera | About")
		end

		it "should have content 'About'" do
			visit 'static_pages/about'
			expect(page).to have_content("About")
		end
	end
end