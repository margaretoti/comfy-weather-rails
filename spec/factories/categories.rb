FactoryGirl.define do
  factory :category do
    sequence(:name) { |c| "jeans#{c}" }
    # selected_icon { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'jeans_icon.png'), 'image/png') }
    # unselected_icon { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'jeans_icon.png'), 'image/png') }

    selected_icon_1x { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'jeans_icon.png'), 'image/png') }
    selected_icon_2x { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'jeans_icon.png'), 'image/png') }
    selected_icon_3x { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'jeans_icon.png'), 'image/png') }
  end
end
