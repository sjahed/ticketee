require 'spec_helper'

feature 'Editing tickets' do
	let!(:aProject)  { FactoryGirl.create(:project)}
	let!(:aTicket)  { FactoryGirl.create(:ticket, project: aProject)}

	before do
		visit '/'
		click_link aProject.name
		click_link aTicket.title
		click_link "Edit Ticket"
	end

	scenario 'with valid attributes' do
		fill_in "Title", with: "A new title for project"
		fill_in "Description", with: "A new description for the project"
		click_button "Update Ticket"

		expect(page).to have_content("Ticket has been updated.")
		expect(page).to_not have_content aTicket.title
	end

	scenario 'with invlaid attributes fails' do
		fill_in "Title", with: ""
		click_button "Update Ticket"

		expect(page).to have_content("Ticket has not been updated.")
		expect(page).to have_content("Title can't be blank")
	end

end
