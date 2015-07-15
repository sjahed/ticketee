require 'spec_helper'


feature 'Viewing project tickets' do
	before do
		user = FactoryGirl.create(:user)
		textmate = FactoryGirl.create(:project,name: "TextMate 2")
		explorer = FactoryGirl.create(:project, name: "Internet Explorer")
		ticket = FactoryGirl.create(:ticket, project: textmate, title: "Make it shiny!",
									description: "Gradients! Starbursts! Oh my!")
		ticket.update(user: user)
		
		visit '/'
	end

	scenario "Viewing a ticket" do
		click_link "TextMate 2"
		expect(page).to have_content("Make it shiny!")
		expect(page).to_not have_content("Standards compliance")

		click_link "Make it shiny!"
		
		within("#ticket h2") do 
			expect(page).to have_content("Make it shiny!")
		end

		expect(page).to have_content("Gradients! Starbursts! Oh my!")
	end
end

