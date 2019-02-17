User.create!(name: "Minh MT",
             email: "minhmt@gmail.com",
             password: "123456",
             password_confirmation: "123456",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

40.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each{|user| user.microposts.create!(content: content)}
end

users = User.all
user  = users.first
following = users[2..40]
followers = users[3..30]
following.each{|followed| user.follow(followed)}
followers.each{|follower| follower.follow(user)}
