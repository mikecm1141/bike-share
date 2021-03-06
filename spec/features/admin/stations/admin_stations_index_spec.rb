require 'rails_helper'

describe "Admin Stations Index" do
  describe "Admin user visits stations index page" do
    before(:each) do
      admin = create(:user, role: 1)
      @station1 = create(:station)
      @station2 = create(:station)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end
    it "shows edit and delete buttons next to each station" do
      visit stations_path

      expect(page).to have_content("Create New Station")

      within("#station-#{@station1.id}") do
        expect(page).to have_content(@station1.name)
        expect(page).to have_content(@station1.dock_count)
        expect(page).to have_content(@station1.city)
        expect(page).to have_content(@station1.installation_date.strftime('%m/%d/%Y'))
        expect(page).to have_button("Edit")
        expect(page).to have_button("Delete")
      end

      within("#station-#{@station2.id}") do
        expect(page).to have_content(@station2.name)
        expect(page).to have_content(@station2.dock_count)
        expect(page).to have_content(@station2.city)
        expect(page).to have_content(@station2.installation_date.strftime('%m/%d/%Y'))
        expect(page).to have_button("Edit")
        expect(page).to have_button("Delete")
      end
    end
    it 'allows an admin to create a new station' do
      visit new_admin_station_path
      fill_in :station_name, with: "New Station"
      fill_in :station_dock_count, with: 0
      fill_in :station_city, with: "New City"
      fill_in :station_installation_date, with: "2018/09/12"

      click_on "Create Station"

      expect(current_path).to eq(stations_path)
      expect(page).to have_content("New Station")
      expect(page).to have_content("New City")
      expect(page).to have_content('09/12/2018')
      expect(page).to have_content('New Station Created')
    end
    it 'does not allow negative dock count' do
      visit new_admin_station_path
      fill_in :station_name, with: "New Station"
      fill_in :station_dock_count, with: -10
      fill_in :station_city, with: "New City"
      fill_in :station_installation_date, with: "09/12/2018"

      click_on "Create Station"

      expect(page).to have_content("Error - Could not create new station")
      expect(current_path).to eq(new_admin_station_path)
    end
  end
end
