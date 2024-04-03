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
      expect(response.body).to eq(
        {
          policy: {
            effectiveDate: '2024-01-01',
            expirationDate: '2025-01-01',
            insuredPerson: {
              name: 'Erling Haaland',
              cpf: '123.456.789-10'
            }
          }
        }
      )
    end
  end
end
