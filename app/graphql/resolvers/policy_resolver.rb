module Resolvers
  class PolicyResolver < BaseResolver
    type Types::PolicyType, null: false
    argument :policy_id, String

    def resolve(policy_id:)
    # chamada api
    end
  end
end
