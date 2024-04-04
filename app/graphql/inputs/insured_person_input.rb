# frozen_string_literal: true

module Inputs
  class InsuredPersonInput < ::Types::BaseInputObject
    argument :name, String
    argument :cpf, String
  end
end
