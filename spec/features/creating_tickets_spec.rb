require 'spec_helper'


feature 'Creating tickets' do
	
	before do
		project = FactoryGirl.create(:project)
		user = FactoryGirl.create(:user)

		visit '/'
		click_link project.name 
		click_link 'New Ticket'
		message = "You need to sign in or sign up before continuing."
		expect(page).to have_content(message)

		fill_in "Name", with: user.name
		fill_in "Password", with: user.password
		click_button "Sign in"

		click_link project.name
		click_link "New Ticket"
	end

	scenario 'create ticket with valid information' do

		fill_in "Title", with: "I have problems"
		fill_in "Description", with: "Not a good program"
		click_button "Create Ticket"
		expect(page).to have_content("Ticket has been created.")

		within "#ticket #author" do
			expect(page).to have_content("Created by sample@example.com")
		end
	end

	scenario "Creating ticket without valid information fails" do
		click_button "Create Ticket"
		expect(page).to have_content("Ticket has not been created.")
		expect(page).to have_content("Title can't be blank")
		expect(page).to have_content("Description can't be blank")
	end

	scenario "description must be longer than 10 characters" do
		fill_in "Title", with: "Non-standard compliance"
		fill_in "Description", with: "It sucks"
		click_button "Create Ticket"
		expect(page).to have_content("Ticket has not been created.")
		expect(page).to have_content("Description is too short")
	end

end


