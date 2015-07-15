require 'spec_helper'

feature 'Editing tickets' do
	let!(:project)  { FactoryGirl.create(:project)}
	let!(:user) { FactoryGirl.create(:user)}
	let!(:ticket) do 
		ticket = FactoryGirl.create(:ticket, project: project)
		ticket.update(user: user)
		ticket
	end

	before do
	    sign_in_as!(user)
		visit '/'
		click_link project.name
		click_link ticket.title
		click_link "Edit Ticket"
	end

	scenario 'with valid attributes' do
		fill_in "Title", with: "A new title for project"
		fill_in "Description", with: "A new description for the project"
		click_button "Update Ticket"

		expect(page).to have_content("Ticket has been updated.")
		expect(page).to_not have_content ticket.title
	end

	scenario 'with invlaid attributes fails' do
		fill_in "Title", with: ""
		click_button "Update Ticket"

		expect(page).to have_content("Ticket has not been updated.")
		expect(page).to have_content("Title can't be blank")
	end

end
