category_data = [ { name: 'Blouse', icon: 'blouse' },
                  { name: 'Button-down', icon: 'button_down' },
                  { name: 'Polo', icon: 'polo' },
                  { name: 'Long Sleeve', icon: 'long_sleeve' },
                  { name: 'Tank', icon: 'tank' },
                  { name: 'T-Shirt', icon: 't_shirt' },
                  { name: 'Vest', icon: 'vest' },
                  { name: 'Sweater', icon: 'sweater' },
                  { name: 'Sweatshirt', icon: 'sweatshirt' },
                  { name: 'Jacket', icon: 'jacket' },
                  { name: 'Coat', icon: 'coat' },
                  { name: 'Jeans', icon: 'jeans' },
                  { name: 'Sweatpants', icon: 'sweatpants' },
                  { name: 'Leggings', icon: 'leggings' },
                  { name: 'Skirt', icon: 'skirt' },
                  { name: 'Dress', icon: 'dress' },
                  { name: 'Shorts', icon: 'shorts' },
                  { name: 'Heels', icon: 'heels' },
                  { name: 'Sandals', icon: 'sandals' },
                  { name: 'Slippers', icon: 'slippers' },
                  { name: 'Flats', icon: 'flats' },
                  { name: 'Boots', icon: 'boots' },
                  { name: 'Rain boots', icon: 'rain_boots' },
                  { name: 'Sneaks', icon: 'sneaks' },
                  { name: 'Dress Shoes', icon: 'dress_shoes' },
                  { name: 'Loafers', icon: 'loafers' },
                  { name: 'Hat', icon: 'hat' },
                  { name: 'Scarf', icon: 'scarf' },
                  { name: 'Cap', icon: 'cap' },
                  { name: 'Mittens', icon: 'mittens' },
                  { name: 'Other', icon: 'other'} ]

category_data.each do |category|
  puts "Seeding category: #{category[:name]}"
  article_category = Category.find_or_initialize_by(name: category[:name])
  puts "About to update: #{category[:name]}"
  article_category.update!(selected_icon: File.open("lib/assets/selected_icons/#{category[:icon] + '.svg'}", 'rb'),
                            unselected_icon: File.open("lib/assets/unselected_icons/#{category[:icon] + '.svg'}", 'rb')
                          )
end
