require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  test "creates default building and room after creation" do
    tenant_name = "tenant_#{SecureRandom.hex(4)}"
    
    Customer.create!(name: tenant_name)

    # The callback switches to the new tenant
    assert_equal tenant_name, Apartment::Tenant.current

    assert_equal 1, Building.count
    building = Building.first
    assert_equal "My First Building", building.name
    assert_equal "123 Main St", building.address

    assert_equal 1, Room.count
    room = Room.first
    assert_equal "101", room.room_number
    assert_equal building.id, room.building_id
  ensure
    Apartment::Tenant.reset
    Apartment::Tenant.drop(tenant_name) rescue nil
  end
end
