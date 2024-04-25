module Resolvers
  class PoliciesResolver < BaseResolver
    type [::Types::PolicyType], null: false

    def resolve
      JSON.parse(policy_request)
    end

    private

    def policy_client
      @policy_client ||= Net::HTTP.new(ENV["INSURANCE_API"], ENV["INSURANCE_API_PORT"])
    end

    def policy_request
      policy_client.start.get("/policies").read_body
    end
  end
end
