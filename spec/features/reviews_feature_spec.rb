require 'rails_helper'

feature 'reviews' do
  context 'reviewing' do
    before{Restaurant.create name:'KFC'}

    scenario 'allow user to leave a review using a form' do
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: 'So so'
      select '3', from: 'Rating'
      click_button 'Leave Review'
      expect(page).to have_content 'So so'
      expect(current_path).to eq '/restaurants'
    end
  end


end


# <% restaurant.reviews.each do |review| %>
#   <%= review.thoughts%>
# <% end %>
