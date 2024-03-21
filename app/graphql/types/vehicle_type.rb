module Types
  class VehicleType < Types::BaseObject
    description "Fields for a vehicle query"

    field :brand,         String, null: false, description: "Vehicle's brand"
    field :model,         String, null: false, description: "Vehicle's model"
    field :year,          String, null: false, description: "Vehicle's year released"
    field :license_plate, String, null: false, description: "Vehicle's license plate"
  end
end
