# frozen_string_literal: true

module Mutations
  class CreatePolicyMutation < Mutations::BaseMutation
    argument :insured_person, ::Inputs::InsuredPersonInput
    argument :vehicle, ::Inputs::VehicleInput

    field :policy, ::Types::PolicyType
    field :errors, [::Types::UserErrorType]

    def resolve(params)
      policy_payload = {
        effective_date: DateTime.now.strftime("%Y-%m-%d"),
        expiration_date: 1.year.from_now.strftime("%Y-%m-%d"),
        insured_person: { **params[:insured_person] },
        vehicle: { **params[:vehicle] }
      }

      contract = ::PolicyContract.new
      validation = contract.call(policy_payload)


      if validation.errors.any?
        user_errors = []
        validation.errors(full: true).to_h.each do |k,v|
          v.each do |k1, v1|
            user_errors << {message: v1.first, path: k}
          end
        end

        return { policy: {}, errors: user_errors }
        end

      {
        "policy": {
          "effective_date": "2024-01-01",
          "expiration_date": "2025-01-01",
          "insured_person": {
            "name": "Erling Haaland",
            "cpf": "123.456.789-10"
          },
          errors: []
        }
      }

    end
  end
end
