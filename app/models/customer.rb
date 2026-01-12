class Customer < ApplicationRecord
  before_create :create_tenant
  after_create :default_data
  before_destroy :drop_tenant

  validates :name, presence: true, uniqueness: true

  def create_tenant
    Apartment::Tenant.create(name)
    Apartment::Tenant.switch!(name)
  end

  def default_data
    Building.create(name: "My First Building", address: "123 Main St")
    Room.create(room_number: "101", building_id: Building.first.id)
  end

  def drop_tenant
    Apartment::Tenant.drop(name)
  end
end
