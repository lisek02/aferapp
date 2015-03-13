require 'rails_helper'

def log_in(user, options={})
	if options[:no_capybara]
		#sign in without using no_capybara
		
		#cookies[:user_id] = user.id
		log_in(user);
		#remember_token = User.new_token
		#cookies[:remember_token] = remember_token
		#user.update_attribute(:remember_token, User.digest(remember_token))
	else
		visit login_path
		fill_in "Email",		with: user.email
		fill_in "Password", with: user.password
		click_button "Log in"
	end
end