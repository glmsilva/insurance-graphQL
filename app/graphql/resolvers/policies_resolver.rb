module Resolvers
  class PoliciesResolver < BaseResolver
    type [::Types::PolicyType], null: true

    def resolve
      JSON.parse(PolicyService.get_policies(token: context[:token]), symbolize_names: true)
    end
  end
end
