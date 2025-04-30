# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Message.destroy_all
Chat.destroy_all
User.destroy_all

first_names = ['Harry', 'Mohamed', 'Kevin', 'Bruno', 'Raheem', 'Marcus', 'Sadio', 'Jack', 'Heung-Min', 'Virgil']
last_names = ['Kane', 'Salah', 'De Bruyne', 'Fernandes', 'Sterling', 'Rashford', 'Mane', 'Grealish', 'Son', 'Van Dijk']

10.times do |i|
  User.create!(
    email: "user#{i+1}@example.com",
    first_name: first_names.sample,  
    last_name: last_names.sample, 
  )
end
users = User.all

10.times do
  sender = users.sample
  receiver = users.where.not(id: sender.id).sample 

  Chat.create!(
    sender_id: sender.id,
    receiver_id: receiver.id,
  )
end

chats = Chat.all

10.times do |i|
  chat = chats.sample
  user = chat.sender
  Message.create!(
    chat_id: chat.id,
    user_id: user.id,
    body: "Message body #{i+1}",
  )
end
