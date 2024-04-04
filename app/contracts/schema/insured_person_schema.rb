module Schema
  InsuredPersonSchema = Dry::Schema.Params do
    required(:insured_person).schema do
      required(:name).filled(:string)
      required(:cpf).filled(:string)
    end
  end
end


