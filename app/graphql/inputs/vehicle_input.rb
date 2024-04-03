# frozen_string_literal: true

module Inputs
  class VehicleInput < ::Types::BaseInputObject
    argument :brand, String, required: true
    argument :model, String, required: true
    argument :year, String, required: true
    argument :license_plate, String, required: true
  end
end
