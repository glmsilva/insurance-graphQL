class PolicyService
  ROUTES = {
    "policy": "/policies/%d",
    "policies": "/policies"
  }

  def get_policy(id:)
    path = ROUTES[:policy] % id
    req = RequestService.get(path)
    JSON.parse(req).deep_symbolize_keys
  end

  def create_policy
  end
end
