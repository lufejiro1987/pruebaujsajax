require 'faker'

20.times do 
    Category.create(name: Faker::Name.unique.name, status: "public_cat")
end
puts "after categories"
categories = Category.pluck(:id)
count = 0
20.times do 
    puts "into sub"
    Subcategory.create(name: Faker::Name.unique.name, category_id: categories[count])
    count = count + 1
end
count = 0
20.times do 
    Type.create(name: Faker::Name.unique.name)
    count = count + 1
end
types = Type.pluck(:id)
count = 0 
20.times do 
    puts "into maker"
    category = Category.find(categories[count])
    marker = Marker.create(name: Faker::Name.unique.name, type_id: types[count])
    marker.categories << category
    count = count + 1
end

