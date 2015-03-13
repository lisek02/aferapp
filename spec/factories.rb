FactoryGirl.define do
	factory :user do
		sequence(:login) { |n| "user#{n}" }
		sequence(:email) { |n| "user#{n}@example.com"}
		password 	"foobar"
		password_confirmation "foobar"
		description "Lorem ipsum"

		factory :admin do
			admin true
		end
	end
end