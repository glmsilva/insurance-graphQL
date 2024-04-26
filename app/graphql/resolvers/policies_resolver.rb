module Resolvers
  class PoliciesResolver < BaseResolver
    type [::Types::PolicyType], null: true

    def resolve
      JSON.parse(policy_request)
    end

    private

    def policy_client
      Net::HTTP.new(ENV["INSURANCE_API"], ENV["INSURANCE_API_PORT"])
    end

    def policy_request
      begin
        policy_client.start.get("/policies").read_body
      rescue Socket::ResolutionError => e
        Rails.logger.info e
      end
    end
  end
end
