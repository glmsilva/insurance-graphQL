module Types
  class InsuredPersonType < Types::BaseObject
    description "Attributes for a Insured Person query"

    field :name, String, null: false, description: "The insured person's name"
    field :cpf,  String, null: false, description: "Insured person's CPF number"
  end
end
