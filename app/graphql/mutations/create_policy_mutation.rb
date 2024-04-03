# frozen_string_literal: true

module Mutations
  class CreatePolicyMutation < Mutations::BaseMutation
    argument :insured_person, ::Inputs::InsuredPersonInput, required: true
    argument :vehicle, ::Inputs::VehicleInput, required: true

    field :policy, ::Types::PolicyType

    def resolve(params)
    binding.pry
    end
  end
end
