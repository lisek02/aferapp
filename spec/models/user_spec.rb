require 'spec_helper'
require 'rspec/its'

describe User do
	before { @user = User.new(login: "example", email: "user@example.com",
						password: "foobar", password_confirmation: "foobar", description: "lorem ipsum") }

	subject { @user }

	it { should respond_to(:login) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }
	it { should respond_to(:remember_token) }
	it { should respond_to(:description) }

	it { should be_valid }

	describe "when user login is not present" do
		before { @user.login = "" }
		it { should_not be_valid }
	end

	describe "when user login is to long" do
		before { @user.login = "a"*51 }
		it { should_not be_valid }
	end

	describe "when password is empty" do
		before { @user.password = "", @user.password_confirmation = "" }
		it { should_not be_valid }
	end

	describe "when password_confirmation doesn't match password" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

	describe "with too short password" do
		before { @user.password = @user.password_confirmation = "a"*5 }
		it { should_not be_valid }
	end

	describe "return user after authentication" do
		before { @user.save }
		let(:found_user) { User.find_by(email: @user.email) }

		describe "with valid password" do
			it { should eq found_user.authenticate(@user.password) }
		end

		describe "with invalid password" do
			let(:user_with_invalid_password) { found_user.authenticate("invalid") }

			it { should_not eq user_with_invalid_password }
			specify { expect(user_with_invalid_password).to be_falsey }
		end
	end

	describe "when user email is not present" do
		before { @user.login = "example", @user.email = "" }
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

	describe "authenticated for a user with nil digest" do
		it "should return nil" do
			expect(@user.authenticated?('')).to be_falsy
		end
	end
end