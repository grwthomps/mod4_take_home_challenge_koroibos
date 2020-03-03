class Olympian < ApplicationRecord
  belongs_to :team
  belongs_to :sport

  has_many :olympian_events
  has_many :events, through: :olympian_events

  validates_presence_of :name,
                        :sex,
                        :age,
                        :height,
                        :weight

  validates_uniqueness_of :name
  validates_numericality_of :age
  validates_numericality_of :height
  validates_numericality_of :weight

  def total_medals_won
    OlympianEvent.where(olympian_id: self.id).where.not(medal: "NA").count
  end

  def self.youngest
    order(:age).limit(1).first
  end

  def self.oldest
    order(:age).reverse_order.limit(1).first
  end
end
