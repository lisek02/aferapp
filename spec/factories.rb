FactoryGirl.define do
	factory :user do
		login 		"test"
		email 		"test@example.com"
		password 	"foobar"
		password_confirmation "foobar"
		description "Lorem ipsum"

		factory :admin do
			admin true
		end
	end
end