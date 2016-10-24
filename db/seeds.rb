category_data = [ { name: 'Blouse', icon: 'blouse' },
                  { name: 'Boots', icon: 'boots' },
                  { name: 'Button-down', icon: 'buttonDown' },
                  { name: 'Cap', icon: 'cap' },
                  { name: 'Coat', icon: 'coat' },
                  { name: 'Dress', icon: 'dress' },
                  { name: 'Dress Shoes', icon: 'dressShoes' },
                  { name: 'Flats', icon: 'flats' },
                  { name: 'Hat', icon: 'hat' },
                  { name: 'Heels', icon: 'heels' },
                  { name: 'Jacket', icon: 'jacket' },
                  { name: 'Leggings', icon: 'leggings' },
                  { name: 'Loafers', icon: 'loafers' },
                  { name: 'Long Sleeve', icon: 'longSleeve' },
                  { name: 'Mittens', icon: 'mittens' },
                  { name: 'Other', icon: 'other'},
                  { name: 'Pants', icon: 'pants' },
                  { name: 'Polo', icon: 'polo' },
                  { name: 'Rain boots', icon: 'rainBoots' },
                  { name: 'Sandals', icon: 'sandals' },
                  { name: 'Scarf', icon: 'scarf' },
                  { name: 'Shorts', icon: 'shorts' },
                  { name: 'Skirt', icon: 'skirt' },
                  { name: 'Slippers', icon: 'slippers' },
                  { name: 'Sneaks', icon: 'sneaks' },
                  { name: 'Sweater', icon: 'sweater' },
                  { name: 'Sweatpants', icon: 'sweatpants' },
                  { name: 'Sweatshirt', icon: 'sweatshirt' },
                  { name: 'Tank', icon: 'tank' },
                  { name: 'T-Shirt', icon: 'tShirt' },
                  { name: 'Vest', icon: 'vest' }, ]

category_data.each do |category|
  puts "Seeding category: #{category[:name]}"
  article_category = Category.find_or_initialize_by(name: category[:name])
  puts "About to update: #{category[:name]}"
  article_category.update!(selected_icon_1x: File.open("lib/assets/categories/selected_icons/1x/#{category[:icon] + '.png'}", 'rb'),
                           selected_icon_2x: File.open("lib/assets/categories/selected_icons/2x/#{category[:icon] + '.png'}", 'rb'),
                           selected_icon_3x: File.open("lib/assets/categories/selected_icons/3x/#{category[:icon] + '.png'}", 'rb'))
end

(0..95).step(5) do |n|
  puts "Seeding weather_type - temp_range: #{n..(n + 4)}"
  if WeatherType.where("temp_range = ?",  n..(n + 4)).nil?
    WeatherType.create!(temp_range: n..(n + 4))
  end
end
