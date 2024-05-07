# frozen_string_literal: true

module Mutations
  class CreatePolicyMutation < Mutations::BaseMutation
    argument :insured_person, ::Inputs::InsuredPersonInput
    argument :vehicle, ::Inputs::VehicleInput

    field :policy, ::Types::PolicyType
    field :errors, [::Types::UserErrorType]

    def resolve(params)
      policy_payload = build_policy_params(params)
      validation = ::PolicyContract.new.call(policy_payload)

      return { policy: {}, errors: build_errors(validation) } if validation.errors.any?


      #if validation.errors.any?
      #  user_errors = []
      #  validation.errors(full: true).to_h.each do |k,v|
      #    v.each do |k1, v1|
      #      user_errors << {message: v1.first, path: k}
      #    end
      #  end

      #  return { policy: {}, errors: user_errors }
      #end

      policy = PolicyService.create_policy(policy_payload)

      return { policy: nil, errors: [] } if policy.nil?

      policy = JSON.parse(policy, symbolize_names: true)

      if policy.has_key? :errors
        policy_errors = policy.each_value.map { |value| { message: value, path: nil } }

        return { policy: nil, errors: policy_errors }
      end

      {
        policy: policy,
        errors: {}
      }

    end

    private

    def build_policy_params(params)
      {
        effective_date: DateTime.now.strftime("%Y-%m-%d"),
        expiration_date: 1.year.from_now.strftime("%Y-%m-%d"),
        insured_person: { **params[:insured_person] },
        vehicle: { **params[:vehicle] }
      }
    end

    def build_errors(policy_contract)
      policy_contract.errors(full: true).map do |error|
        {
          message: error.text,
          path: error.path.first
        }
      end
    end
  end
end
