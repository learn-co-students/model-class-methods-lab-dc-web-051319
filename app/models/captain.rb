# frozen_string_literal: true

class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.includes(boats: { boat_classifications: :classification }).where(classifications: { name: 'Catamaran' }).distinct
  end

  def self.sailors
    Captain.includes(boats: { boat_classifications: :classification }).where(classifications: { name: 'Sailboat' }).distinct
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: { name: 'Motorboat' })
  end

  def self.talented_seafarers
    where('id IN (?)', sailors.pluck(:id) & motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    where.not('id IN (?)', sailors.pluck(:id))
  end
end
