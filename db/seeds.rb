Message.destroy_all
Chat.destroy_all
User.destroy_all

first_names = ['Harry', 'Mohamed', 'Kevin', 'Bruno', 'Raheem', 'Marcus', 'Sadio', 'Jack', 'Heung-Min', 'Virgil']
last_names = ['Kane', 'Salah', 'De Bruyne', 'Fernandes', 'Sterling', 'Rashford', 'Mane', 'Grealish', 'Son', 'Van Dijk']

# Crear usuarios
10.times do |i|
  User.create!(
    email: "user#{i}@example.com",
    first_name: first_names.sample,  
    last_name: last_names.sample, 
    password: "password123"
  )
end
users = User.all

# Crear chats
10.times do
  sender = users.sample
  receiver = users.where.not(id: sender.id).sample 

  Chat.create!(
    sender_id: sender.id,
    receiver_id: receiver.id,
  )
end

chats = Chat.all
chats.each_with_index do |chat, i|
  sender = chat.sender
  Message.create!(
    chat_id: chat.id,
    user_id: sender.id,
    body: "Message body #{i+1}",
  )
end

10.times do |i|
  chat = chats.sample
  user = [chat.sender, chat.receiver].sample
  Message.create!(
    chat_id: chat.id,
    user_id: user.id,
    body: "Additional message body #{i+1}",
  )
end