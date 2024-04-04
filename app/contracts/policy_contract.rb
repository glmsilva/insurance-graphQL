class PolicyContract < ApplicationContract
  json(Schema::InsuredPersonSchema, Schema::VehicleSchema) do
    required(:effective_date).filled(:string)
    required(:expiration_date).filled(:string)
  end
end
