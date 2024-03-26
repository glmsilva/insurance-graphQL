module Services
  class PolicyService
    ROUTES = {
      "policy" = "/policies/%d",
      "policies" = "/policies"
    }

    def get_policy(id)
      path = ROUTES[:policy] % id
      req = RequestService.get(path)
      req.to_h
    end

    def create_policy
    end
  end
end
