require 'faker'
Category.create(name: "Housing")
Category.create(name: "Employment")
Category.create(name: "Buy/Sell")
Category.create(name: "Employment")
Category.create(name: "Other")


Category.all.each do |category|
  rand(4..6).times do
    Post.create(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.sentence(3),
      contact: "#{Faker::Internet.email} or #{Faker::PhoneNumber.cell_phone}",
      comission: "#{Faker::Number.number(rand(1..3))}.#{Faker::Number.number(2)}",
      category_id: category.id,
      hidden_key: Faker::Internet.password(6)
      )
  end
end