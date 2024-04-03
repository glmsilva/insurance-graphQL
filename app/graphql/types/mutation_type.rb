# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_policy, mutation: Mutations::CreatePolicyMutation
  end
end
