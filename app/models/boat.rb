# frozen_string_literal: true

class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all[0..4]
  end

  def self.dinghy
    where('length <?', 20)
  end

  def self.ship
    where('length >=?', 20)
  end

  def self.last_three_alphabetically
    order(:name).reverse[0..2]
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    all.select do |boat|
      boat.classifications.any? { |obj| obj.name == 'Sailboat' }
    end
  end

  def self.with_three_classifications
    all.select do |boat|
      boat.classifications.length == 3
    end
  end
end
