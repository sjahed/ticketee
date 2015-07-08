require 'spec_helper'

feature "Editing Projects" do
	before do
		FactoryGirl.create(:project, name: "TextMate 2")
		visit '/'
		click_link 'TextMate 2'
		click_link 'Edit Project'
	end
	
	scenario "Updating a project" do 
		fill_in "Name", with: "TextMate 2 beta"
		fill_in "Description", with: "Somethign else for description"
		click_button "Update Project"
		expect(page).to have_content("Project has been updated.")
	end
	
	scenario 'Updating project with invalid attributes fails' do
		fill_in "Name", with: ""
		click_button "Update Project"
		expect(page).to have_content("Project has not been updated.")
	end

end