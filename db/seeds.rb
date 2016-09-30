# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

category_data = [ [name: 'Blouse', icon: 'blouse'],
                  [name: 'Button-down', icon: 'button_down'],
                  [name: 'Flannel', icon: 'flannel'],
                  [name: 'Polo', icon: 'polo'],
                  [name: 'Long Sleeve', icon: 'long_sleeve'],
                  [name: 'Tank', icon: 'tank'],
                  [name: 'T-Shirt', icon: 't-shirt'],
                  [name: 'Vest', icon: 'vest'],
                  [name: 'Sweater', icon: 'sweater'],
                  [name: 'Sweatshirt', icon: 'sweatshirt'],
                  [name: 'Jacket', icon: 'jacket'],
                  [name: 'Coat', icon: 'coat'],
                  [name: 'Jeans', icon: 'jeans'],
                  [name: 'Sweatpants', icon: 'sweatpants' ],
                  [name: 'Leggings', icon: 'leggings'],
                  [name: 'Skirt', icon: 'skirt'],
                  [name: 'Dress', icon: 'dress'],
                  [name: 'Shorts', icon: 'shorts'],
                  [name: 'Heels', icon: 'heels'],
                  [name: 'Sandals', icon: 'sandals'],
                  [name: 'Slippers', icon: 'slippers'],
                  [name: 'Flats', icon: 'flats'],
                  [name: 'Boots', icon: 'rain_boots'],
                  [name: 'Sneaks', icon: 'sneaks'],
                  [name: 'Dress Shoes', icon: 'dress_shoes'],
                  [name: 'Loafers'], icon: 'loafers'],
                  [name: 'Hat', icon: 'hat'],
                  [name: 'Scarf', icon: 'scarf'],
                  [name: 'Cap', icon: 'cap'],
                  [name: 'Mittens', icon: 'mittens'],
                  [name: 'Other', icon: 'other'],
                ]

category_data.each do |category_name|
  Category.create!(name: name, icon: fixture_file_upload(Rails.root.join('lib', 'assets', 'selected_icons', "#{icon}+'.svg'"), 'image/svg'),
                                                         icon: fixture_file_upload(Rails.root.join('lib', 'assets', 'unselected_icons', "#{icon}+'.svg'"), 'image/svg') )
end
