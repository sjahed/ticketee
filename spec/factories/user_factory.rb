FactoryGirl.define do
	sequence(:email) { |n| "user#{n}@example.com"}
	factory :user do
		name "someone"
		email { generate(:email) } 
		password "password"

		factory :admin_user do
			admin true
		end
	end
end

