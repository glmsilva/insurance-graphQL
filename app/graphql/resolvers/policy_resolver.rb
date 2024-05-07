module Resolvers
  class PolicyResolver < BaseResolver
    type ::Types::PolicyType, null: false
    argument :policy_id, Integer

    def resolve(policy_id:)
      JSON.parse(PolicyService.get_policy({ id: policy_id, token: context[:token] }), symbolize_names: true)
    end
  end
end
