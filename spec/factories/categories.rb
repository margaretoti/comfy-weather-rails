FactoryGirl.define do
  factory :category do
    name "jeans"
    selected_icon { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'jeans_icon.png'), 'image/png') }
    unselected_icon { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'jeans_icon.png'), 'image/png') }                    
  end
end
