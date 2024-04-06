# frozen_string_literal: true

module Inputs
  class InsuredPersonInput < ::Types::BaseInputObject
    argument :name, String, required: true
    argument :cpf, String, required: true
  end
end
