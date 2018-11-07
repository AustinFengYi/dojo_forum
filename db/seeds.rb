# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#User
User.destroy_all
file = File.open("#{Rails.root}/public/avatar/admin.png")
User.create!(
  name:'Admin', 
  email:'admin@example.com', 
  password:'12345678', 
  role:'admin', 
  avatar: file,
  introduction:'很榮幸能有機會向各位進行自我介紹。我叫xxx,今年xxx歲，我學的是xxx專業。這次來應聘我覺得自己有能力勝任這 份工作，並且有着濃厚的興趣，XXX的基本工作已經熟練，如果能給我個機會，我一定會在工作中好好地表現的，一定不會讓你們失望。 我很樂意回答各位考官所提出來的任何問題，謝謝！'
  )
puts "Default admin created!"

#Catogory
Category.destroy_all
category_list = [
  { name: "CULTURE"},
  { name: "TECH" },
  { name: "STARTUPS" },
  { name: "POLITICS" },
  { name: "DESIGN" },
  { name: "HEALTH" },
  { name: "FOOD" },
  { name: "GAMING" }
]

category_list.each do |category|
  Category.create( name: category[:name] )
end

puts "Categories created!"
puts "now you have #{Category.count} categories data"
