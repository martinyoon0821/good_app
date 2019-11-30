##require 'faker'
##Faker::Config.locale = 'ko'

##4.times do
  ##  user = User.create(email: Faker::Internet.email, name: Faker::Name.name, password: "111111", password_confirmation: "111111")
    
    ##5.times do 
      ##  user.boards.create(title: Faker::Lorem.word, content: Faker::Lorem.paragraph)
##    end
##end

##Board.all.each do |board|
  ##  3.times do
    ##    board.comments.create(body: Faker::Kpop.iii_groups, user: User.first)
    ##end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?