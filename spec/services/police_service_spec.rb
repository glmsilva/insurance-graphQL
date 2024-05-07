require 'rails_helper'

describe "PolicyService" do
  describe "#get_policy" do
    before do
      stub_request(:get, "insurance-rest:5000/policies/1")
        .to_return(
          body: { 
            policy_id: "abcd1231",
            effective_date: "10-03-2024",
            expiration_date: "10-03-2025",
            insured_person: {
                name: "Zlatan Ibrahimovic",
                cpf: "123.456.789-10"
              },
            vehicle: {
              brand: "Volkswagen",
              model: "Fuska",
              year: "1969",
              license_plate: "ABC1D23"
              }
          }.to_json,

          status: 200
        )
    end

    it "shows a policy from policy service" do
      res = {
        policy_id: "abcd1231",
        effective_date: "10-03-2024",
        expiration_date: "10-03-2025",
        insured_person: {
          name: "Zlatan Ibrahimovic",
          cpf: "123.456.789-10",
        },
        vehicle: {
          brand: "Volkswagen",
          model: "Fuska",
          year: "1969",
          license_plate: "ABC1D23"
        }
      }.to_json

      service = PolicyService.get_policy(id: 1)
      expect(service).to eq(res)
    end
  end
end
