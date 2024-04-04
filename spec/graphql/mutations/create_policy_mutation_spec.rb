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
          }
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
                cpf: "123.456.789-20"
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


      it 'throws error' do
        post '/graphql', params: { query: query }

        response_body = JSON.parse(response.body)
        binding.pry
        expect(response_body["data"]["createPolicy"]).to eq(
          { "policy" => { "errors": "erro" } }
        )
      end
    end
  end
end
