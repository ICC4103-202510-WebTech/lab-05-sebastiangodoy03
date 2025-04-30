class Message < ApplicationRecord
    belongs_to :chat
    belongs_to :user

    # Validaciones
    validates :body, presence: true
end
