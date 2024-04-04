module Schema
  VehicleSchema = Dry::Schema.Params do
    required(:vehicle).schema do
      required(:brand).filled(:string)
      required(:model).filled(:string)
      required(:year).filled(:string)
      required(:license_plate).filled(:string)
    end
  end
end
