require 'spec_helper'

feature 'hidden links' do
	let(:user) { FactoryGirl.create(:user) }
	let(:admin) { FactoryGirl.create(:admin_user) }
	let(:project) { FactoryGirl.create(:project) }

	context "anonymous users" do
		scenario "cannot see the new project link" do
			visit '/'
			assert_no_link_for "New Project"
		end

		scenario "cannot see the edit projects link" do
			visit project_path(project)
			assert_no_link_for "Edit Project"
		end
		
		scenario "cannot see the delete project link" do
			visit project_path(project)
			assert_no_link_for "Delete Project" 
		end

	end

	context "regular users" do
		before { sign_in_as!(user) }
		scenario "cannot see the new project link" do
			visit '/'
			assert_no_link_for "New Project"
		end

		scenario "cannot see the edit projects link" do
			visit project_path(project)
			assert_no_link_for "Edit Project"
		end

		scenario "cannot see the delete project link" do
			visit project_path(project)
			assert_no_link_for "Delete Project"
		end
	end

	context "admin users" do
		before {sign_in_as!(admin) }
		scenario "can see the new project link" do
			visit '/'
			assert_link_for "New Project"
		end

		scenario "can see the edit projects link" do
			visit project_path(project)
			assert_link_for "Edit Project"
		end

		scenario "can see the delete project link" do
			visit project_path(project)
			assert_link_for "Delete Project"
		end
	end
end

