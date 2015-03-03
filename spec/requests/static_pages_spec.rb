require 'spec_helper'

describe "Static pages" do

	let(:base_title) { "Radio Afera" }

	subject { page }

	describe "Home page" do

		before { visit root_path }

		it { should have_title(base_title) }
		it { should have_content("Welcome") }
	end

	describe "Contact page" do

		before { visit contact_path }

		it { should have_title("#{base_title} | Contact") }
		it { should have_content("Contact") }
	end

	describe "About page" do

		before { visit about_path }

		it { should have_title("#{base_title} | About") }
		it { should have_content("About") }
	end
end