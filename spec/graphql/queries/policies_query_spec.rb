require 'rails_helper'

describe 'Policies Query', type: :request do
  context 'when query all policies' do
    before do
      stub_request(:get,"http://insurance-rest:5000/policies")
        .to_return(body: [{
            id: 1,
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
          }
        ].to_json,
                   status: 200)
    end
    it 'shows successfully' do
      query =
        <<-String
        query {
          policies {
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

      post '/graphql', params: { query: query }, headers: { 'AUTHORIZATION' => 'Bearer tokendeteste' }

      response_body = JSON.parse(response.body)

      expect(response_body["data"]["policies"]).to eq(
        [
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
        ]
      )
    end
  end
end
