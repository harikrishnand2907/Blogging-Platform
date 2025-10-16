user = User.create(email: "test@example.com", password: "password")

Post.create(title: "First Post", content: "Welcome to the blog!", user: user)
Post.create(title: "Second Post", content: "Rails 7 is awesome!", user: user)
