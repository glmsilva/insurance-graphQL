module Types
  class PolicyType < Types::BaseObject
    description "a policy type"

    field :policy_id, ID, null: false
    field :effective_date, String, null: false, description: "the specific day when the insurance coverage begins"
    field :expiration_date, String, null: false, description: "the day the insurance coverage ends"
    field :insured_person, Types::InsuredPersonType, null: false, description: "person who will receive the benefit under the insurance policy after the occurrence loss"
    field :vehicle, Types::VehicleType, null: false, description: "the good of the insured"

    def policy_id
      object["id"]
    end
  end
end
