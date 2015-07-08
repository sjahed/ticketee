require 'spec_helper'


feature 'Creating tickets' do
	
	before do
		FactoryGirl.create(:project, name: "TextMate 2")
		visit '/'
		click_link 'TextMate 2'
		click_link 'New Ticket'
	end

	scenario 'create ticket with valid information' do

		fill_in "Title", with: "I have problems"
		fill_in "Description", with: "Not a good program"
		click_button "Create Ticket"
		expect(page).to have_content("Ticket has been created.")
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


