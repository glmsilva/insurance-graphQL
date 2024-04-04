module Types
  class UserErrorType < BaseObject
    field :message, String, null: false
    field :path, String
  end
end
