require 'rails_helper'

describe 'Create Policy Mutation', type: :request do
  context 'when all attributes are valid' do
    let(:query) do
      <<-Mutation
        mutation {
          createPolicy(input: {
          insuredPerson: {
            name: "Erling Haaland",
            cpf: "123.456.789-10"
          },
          vehicle: {
            brand: "Volkswagen",
            model: "Fusca",
            year: "1969",
            licensePlate: "ABC1D23"
          }}
        ){
          policy {
            effectiveDate
            expirationDate
            insuredPerson {
              name
              cpf
            }
          }
          errors { message }
        }
      }
      Mutation
    end

    it 'creates successfully' do
      post '/graphql', params: { query: query }

      response_body = JSON.parse(response.body)
      expect(response_body["data"]["createPolicy"]).to eq(
        {
          "policy"=> {
           "effectiveDate" =>"2024-01-01",
            "expirationDate" => '2025-01-01',
            "insuredPerson" => {
              "name"=> 'Erling Haaland',
              "cpf"=> '123.456.789-10'
            }
          },
          "errors" => nil
        }
      )
    end
  end

  context 'when attributes are not valid' do
    context 'when insured person is not sended' do
      let(:query) do
        <<-Mutation
          mutation {
            createPolicy(input: {
              insuredPerson: {
                name: "",
                cpf: ""
              },
              vehicle: {
                brand: "",
                model: "",
                year: "1969",
                licensePlate: "ABC1D23"
              }}
            ){
              policy {
                effectiveDate
                expirationDate
                insuredPerson {
                  name
                  cpf
                }
              }
            errors { message }
          }
        }
      Mutation
    end


      it 'does not create a policy' do
        post '/graphql', params: { query: query }

        response_body = JSON.parse(response.body)
        expect(response_body["data"]["createPolicy"]["policy"]).to eq nil
        expect(response_body["data"]["createPolicy"]["errors"]).to eq([
          { "message" => "name must be filled" },
          { "message" => "cpf must be filled" },
          { "message" => "brand must be filled" },
          { "message" => "model must be filled" }
        ])

      end
    end
  end
end
