require 'spec_helper'

describe "User pages"	do
	
	subject { page }

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }

		it { should have_title(full_title(user.login)) }
		it { should have_content(user.login) }
	end

	describe "visit signup path" do
		before { visit signup_path }

		it { should have_title(full_title('Sign up')) }
		it { should have_content('Sign up') }
	end

	describe "signup" do
		before { visit signup_path }

		let(:submit) { "Create my account" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "user_login",			with: "example"
				fill_in "user_email",			with: "user@example.com"
				fill_in "user_password",		with: "foobar"
				fill_in "user_password_confirmation", with: "foobar"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving the user" do
				before { click_button submit }
				let(:user) { User.find_by(email: 'user@example.com') }

				it { should have_link('Log out') }
				it { should have_title(full_title(user.login)) }
				it { should have_selector('div.alert.alert-success', text: 'Welcome') }
			end
		end
	end

	describe "edit" do
		let(:user) { FactoryGirl.create(:user) }

		before do
			log_in user
			visit edit_user_path(user)
		end

		describe "with valid information" do
			let(:new_login) { "newlogin" }
			let(:new_email) { "new@example.com" }

			before do
				fill_in "Login",				with: new_login
				fill_in "Email",				with: new_email
				fill_in "Password",			with: user.password
				fill_in "Password confirmation", with: user.password_confirmation
				click_button "Save changes"
			end

			it { should have_title(full_title(new_login)) }
			it { should have_selector('div.alert.alert-success') }
			it { should have_link('Log out', href: logout_path) }
			specify { expect(user.reload.login).to eq(new_login) }
			specify { expect(user.reload.email).to eq(new_email) }
		end

		describe "with invalid information" do
			before { click_button "Save changes" }

			it { should have_content('error') }
		end
	end
end