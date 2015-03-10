require 'rails_helper'

def log_in(user, options={})
	if options[:no_capybara]
		#sign in without using no_capybara
		remember_token = User.new_remember_token
		cookied[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.digest(remember_token))
	else
		visit login_path
		fill_in "Email",		with: user.email
		fill_in "Password", with: user.password
		click_button "Log in"
	end
end