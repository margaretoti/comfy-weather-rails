# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# require ActionDispatch::TestProcess

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

  # path1 = fixture_file_upload(Rails.root.join('lib', 'assets', 'unselected_icons', "#{category[:icon] + '.svg'}"))
  # puts "path1 using fixture_file_upload: #{path1}"
  # type1 = MIME::Types.type_for("lib/assets/unselected_icons/#{category[:icon] + '.svg'}").first.content_type
  # puts "path1 content type is: #{type1}"
  #
  # path2 = File.open("lib/assets/unselected_icons/#{category[:icon] + '.svg'}", 'rb')
  # puts "path2: #{path2}"
  # type2 = MIME::Types.type_for("lib/assets/unselected_icons/#{category[:icon] + '.svg'}").first.content_type
  # puts "path2 content type is: #{type2}"

  # article_category.update!(selected_icon: fixture_file_upload(Rails.root.join('lib', 'assets', 'selected_icons', "#{category[:icon] + '.svg'}"), 'image/svg'),
  #                           unselected_icon: fixture_file_upload(Rails.root.join('lib', 'assets', 'unselected_icons', "#{category[:icon] + '.svg'}"), 'image/svg')
  #                         )
end
