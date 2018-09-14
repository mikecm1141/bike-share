require 'rails_helper'

describe 'As an admin' do
  describe 'When I visist the admin dashboard' do
    before(:each) do
      @admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      user1, user2 = create_list(:user, 2)

      @order1 = create(:order, user_id: user1.id, status: 'ordered')
      @order2 = create(:order, user_id: user1.id, status: 'paid')
      @order3 = create(:order, user_id: user2.id, status: 'cancelled')
      @order4 = create(:order, user_id: user2.id, status: 'completed')
    end
    it 'shows me a list of all orders' do
      visit admin_dashboard_path

      expect(page).to have_content("Order ##{@order1.id}")
      within("#order-status-#{@order1.id}") do
        expect(page).to have_content(@order1.status)
      end
      expect(page).to have_content("Order ##{@order2.id}")
      within("#order-status-#{@order2.id}") do
        expect(page).to have_content(@order2.status)
      end
      expect(page).to have_content("Order ##{@order3.id}")
      within("#order-status-#{@order3.id}") do
        expect(page).to have_content(@order3.status)
      end
      expect(page).to have_content("Order ##{@order4.id}")
      within("#order-status-#{@order4.id}") do
        expect(page).to have_content(@order4.status)
      end
    end
  end
end



# As an admin user,
# When I visit the admin dashboard,
# I see a list of all orders,
# I see the total number of orders for each status ("Ordered", "Paid", "Cancelled", "Completed"),
# I see a link for each individual order,
# I can filter orders to display by each status type ("Ordered", "Paid", "Cancelled", "Completed"),
# I have links to transition between statuses
#
# I can click on "cancel" on individual orders which are "paid" or "ordered"
# I can click on "mark as paid" on orders that are "ordered"
# I can click on "mark as completed" on orders that are "paid"