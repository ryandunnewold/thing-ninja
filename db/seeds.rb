user = User.create(email: 'ryan.dunnewold@metova.com', username: 'stunnawold', password: 'password')

3.times do
  list = user.lists.create(title: 'This is a list')
  10.times do
    list.things.create(description: 'This is something on this list')
  end
end