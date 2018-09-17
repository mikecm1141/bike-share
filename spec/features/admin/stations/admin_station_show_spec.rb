require 'rails_helper'

describe 'Admin Station Show Page' do
  describe 'As an admin user when I visit a station show page' do
    it 'shows me station attributes and the option to edit or delete' do
      station = create(:station)
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_station_path(station)

      expect(page).to have_content(station.name)
      expect(page).to have_content(station.dock_count)
      expect(page).to have_content(station.city)
      expect(page).to have_content(station.installation_date.strftime('%m/%d/%Y'))
      expect(page).to have_content("Edit")
      expect(page).to have_content("Delete")
    end
  end
end
