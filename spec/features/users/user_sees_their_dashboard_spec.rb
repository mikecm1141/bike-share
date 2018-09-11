require 'rails_helper'

describe 'As a user' do
  describe 'When I visit /dashboard' do
    before(:each) do
      @accessory1, @accessory2, @accessory3, @accessory4 = create_list(:accessory, 4)
      @user = create(:user)
      @order1 = @user.orders.create(status: 'paid')
      @order1.order_accessories.create(accessory: @accessory1, quantity: 1, unit_price: @accessory1.price)
      @order1.order_accessories.create(accessory: @accessory2, quantity: 1, unit_price: @accessory2.price)
      @order1.order_accessories.create(accessory: @accessory3, quantity: 1, unit_price: @accessory3.price)

      @order2 = @user.orders.create(status: 'ordered')
      @order2.order_accessories.create(accessory: @accessory1, quantity: 1, unit_price: @accessory1.price)
      @order2.order_accessories.create(accessory: @accessory2, quantity: 1, unit_price: @accessory2.price)
      @order2.order_accessories.create(accessory: @accessory3, quantity: 1, unit_price: @accessory3.price)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end
    it 'displays a list of my orders' do
      visit dashboard_path

      expect(page).to have_content(@user.username)
      expect(page).to have_content("Order ##{@order1.id}")
      expect(page).to have_content("Order ##{@order2.id}")
    end
    it 'takes me to the order page when I click on an order' do
      visit dashboard_path
      save_and_open_page

      click_link "Order ##{@order1.id}"
      expect(page).to have_content("Order ##{@order1.id}")

      expect(page).to have_content(@order1.accessories[0].name)
      within("#order-accessory-quantity-#{@order1.order_accessories[0].id}") do
        expect(page).to have_content(@order1.order_accessories[0].quantity)
      end
      within("#order-accessory-subtotal-#{@order1.order_accessories[0].id}") do
        expect(page).to have_content(@order1.order_accessories[0].subtotal)
      end

      expect(page).to have_content(@order1.accessories[1].name)
      within("#order-accessory-quantity-#{@order1.order_accessories[1].id}") do
        expect(page).to have_content(@order1.order_accessories[1].quantity)
      end

      expect(page).to have_content(@order1.accessories[2].name)
      within("#order-accessory-quantity-#{@order1.order_accessories[2].id}") do
        expect(page).to have_content(@order1.order_accessories[2].quantity)
      end
    end
  end
end
