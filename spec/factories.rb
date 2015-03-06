FactoryGirl.define do
	factory :user do
		login 		"test"
		email 		"test@example.com"
		password 	"foobar"
		password_confirmation "foobar"
		description "Lorem ipsum"
	end
end