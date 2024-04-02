module Resolvers
  class PolicyResolver < BaseResolver
    type ::Types::PolicyType, null: false
    argument :policy_id, Integer

    def resolve(policy_id:)
      JSON.parse(policy_request(id: policy_id))
    end

    private

    def policy_client
      @policy_client ||= Net::HTTP.new("insurance-rest", 3000)
    end

    def policy_request(id:)
      policy_client.start.get("/policies/#{id}").read_body
    end
  end
end
