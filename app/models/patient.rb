class Patient < ApplicationRecord
  has_many :doctor_patients
  has_many :doctors, through: :doctor_patients

  def self.adult_patients
    self.where('age > 18')
  end

  def self.sort_alpha
    self.order(:name)
  end
end