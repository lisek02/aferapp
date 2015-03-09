require 'spec_helper'

describe "Authentication" do
	subject { page }

	describe "login page" do
		before { visit login_path }

		it { should have_title(full_title("Log in")) }
		it { should have_content("Log in") }
	end

	describe "login" do
		before { visit login_path }

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				fill_in "Email", 		with: user.email
				fill_in "Password", 	with: user.password
				click_button "Log in"
			end

			it { should have_title(full_title(user.login)) }
			it { should have_link('Profile',			href: user_path(user)) }
			it { should have_link('Log out', 			href: logout_path) }
			it { should_not have_link('Log in',		href: login_path) }

			describe "followed by log out" do
				before { click_link "Log out" }
				it { should have_link('Log in') }
			end
		end

		describe "with invalid informatino" do
			before { click_button "Log in" }

			it { should have_title(full_title('Log in')) }
			it { should have_selector('div.alert.alert-error') }

			describe "after visiting another page" do
				before { click_link "Home" }
				it { should_not have_selector('div.alert.alert-error') }
			end
		end
	end
end
