require 'rails_helper'

describe 'Policy Query', type: :request do
  context 'when given a proper id' do
    before do
      stub_request(:get, "insurance-rest:3000/policies/1")
        .to_return(
          body: { 
            policy_id: "1",
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

    it 'shows successfully' do
      policy_id = 1
      query =
        <<-String
          query {
            policy(policyId: #{policy_id})
              {
                policyId
                effectiveDate
                expirationDate
                insuredPerson {
                  name
                  cpf
                }
                vehicle {
                  brand
                  model
                  year
                  licensePlate
                }
              }
          }
        String

      post '/graphql', params: {query: query}

      response_body = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(response_body["data"]["policy"]).to eq(
        {
          "policyId" => "1",
          "effectiveDate" => "10-03-2024",
          "expirationDate" => "10-03-2025",
          "insuredPerson" => {
            "name" => "Zlatan Ibrahimovic",
            "cpf" => "123.456.789-10"
          },
          "vehicle" => {
            "brand" => "Volkswagen",
            "model" => "Fuska",
            "year" => "1969",
            "licensePlate" => "ABC1D23"
          }
        }
      )
    end
  end
end
