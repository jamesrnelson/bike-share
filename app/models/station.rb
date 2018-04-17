class Station < ApplicationRecord
  validates_presence_of :name, :dock_count, :city, :installation_date
  before_save :generate_slug

  def generate_slug
    self.slug = name.parameterize
  end

  def self.alphabetize
    order(:name)
  end

  def self.total
    count
  end

  def self.avg_bikes
    average(:dock_count)
  end

  def self.most_bikes
    most = maximum(:dock_count)
    where(dock_count: most)
  end

  def self.fewest_bikes
    fewest = minimum(:dock_count)
    where(dock_count: fewest)
  end

  def self.newest
    order(:installation_date).first
  end

  def self.oldest
    order(installation_date: :desc).first
  end
end
