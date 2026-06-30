class Run < ApplicationRecord
  attr_accessor :hours, :minutes, :seconds
  belongs_to :user

  before_validation :convert_to_seconds
  validates :date, presence: true
  validates :distance, presence: true, numericality: { greater_than: 0 }
  validates :minutes, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 59 }
  validates :seconds, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 59 }

  def hours
  @hours.presence || (duration / 3600 if duration.present?)
  end

  def minutes
    @minutes.presence || ((duration % 3600) / 60 if duration.present?)
  end

  def seconds
    @seconds.presence || (duration % 60 if duration.present?)
  end

  private

  def convert_to_seconds
    self.duration = (hours.to_i * 3600) + (minutes.to_i * 60) + seconds.to_i
  end
end
