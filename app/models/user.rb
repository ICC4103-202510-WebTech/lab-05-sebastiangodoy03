class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :sent_chats, class_name: 'Chat', foreign_key: 'sender_id'
    has_many :received_chats, class_name: 'Chat', foreign_key: 'receiver_id'
    has_many :messages

    # Validaciones
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Email must be unique" }
end
