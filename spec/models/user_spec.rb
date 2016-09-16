require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.new(name: "Danjin")
  }

=begin
  describe "Associations" do
    it { should have_many(:outfit) }
  end
=end

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
    it { should validate_presence_of(:name)}
  end
end
