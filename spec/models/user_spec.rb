require 'spec_helper'

describe User do
	before { @user = User.new(login: "example", email: "user@example.com") }

	subject { @user }

	it { should respond_to(:login) }
	it { should respond_to(:email) }

	it { should be_valid }

	describe "when user login is not present" do
		before { @user.login = "" }
		it { should_not be_valid }
	end

	describe "when user email is not present" do
		before { @user.login = "example", @user.email = "" }
		it { should_not be_valid }
	end

	describe "when user login is to long" do
		before { @user.login = "a"*51 }
		it { should_not be_valid }
	end

	describe "when email is already in use" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end

		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				expect(@user).not_to be_valid
			end
		end
	end

	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				expect(@user).to be_valid
			end
		end
	end
end