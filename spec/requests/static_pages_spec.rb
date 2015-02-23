require 'spec_helper'

describe "Static pages" do

	let(:base_title) { "Radio Afera" }

	describe "Home page" do

		before { visit root_path }

		it "should have title 'Radio Afera'" do
			expect(page).to have_title(base_title)
		end

		it "should have content 'Radio Afera'" do
			expect(page).to have_content("Welcome")
		end
	end

	describe "Contact page" do

		before { visit 'static_pages/contact' }

		it "should have title 'Radio Afera | Contact" do
			expect(page).to have_title("#{base_title} | Contact")
		end

		it "should have content 'Contact'" do
			expect(page).to have_content("Contact")
		end
	end

	describe "About page" do

		before { visit 'static_pages/about' }

		it "should have title 'Radio Afera | About" do
			expect(page).to have_title("#{base_title} | About")
		end

		it "should have content 'About'" do
			expect(page).to have_content("About")
		end
	end
end