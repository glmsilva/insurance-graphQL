module Resolvers
  class PoliciesResolver < BaseResolver
    type [::Types::PolicyType], null: false

    def resolve
      JSON.parse(policy_request)
    end

    private

    def policy_client
      @policy_client ||= Net::HTTP.new("insurance-rest", 3000)
    end

    def policy_request
      policy_client.start.get("/policies").read_body
    end
  end
end
