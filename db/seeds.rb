user = User.create(email: 'ryan.dunnewold@metova.com', username: 'stunnawold', password: 'password')

10.times do
  user.things.create(description: 'This is something I need to do')
end