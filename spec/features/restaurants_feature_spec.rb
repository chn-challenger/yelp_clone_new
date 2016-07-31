require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants has been added' do
    before do
      Restaurant.create(name:'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'adding restaurants' do
    scenario 'add a restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      fill_in 'Description', with: 'Chicken'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(page).to have_content 'Chicken'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'viewing restaurants' do
    let!(:kfc){Restaurant.create(name:'KFC')}

    scenario 'let a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do
    before{Restaurant.create name: 'KFC', description: 'Disgusting fried chicken'}

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky'
      fill_in 'Description', with: 'Disgusting fried chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky'
      expect(page).to have_content 'Disgusting fried chicken'
      expect(current_path).to eq "/restaurants"
    end
  end

  context 'deleting restaurants' do
    before{Restaurant.create name: 'KFC', description: 'Chicken'}

    scenario 'let a user delete a restaurant' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
      expect(current_path).to eq "/restaurants"      
    end
  end

end
# <%= link_to "Delete #{restaurant.name}", restaurant_path(restaurant), method: :delete %>

# No restaurants yet
# <a href='#'>Add a restaurant</a>


# <h2><%= restaurant.name %></h2>
# <a href="/restaurants/#{restaurant.id}"><%=restaurant.name %></a>
