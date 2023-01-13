class Doctor < ApplicationRecord
  belongs_to :hospital
  has_many :doctor_patients
  has_many :patients, through: :doctor_patients

  def patient_count
    self.patients.size
  end

  def self.sort_by_patient_count
    self.joins(:doctor_patients)
    .select('doctors.*, count(doctor_patients) as patient_count')
    .group(:id)
    .order('patient_count desc')
  end
end
