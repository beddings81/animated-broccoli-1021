class AddPatientRefToDoctorPatients < ActiveRecord::Migration[5.2]
  def change
    add_reference :doctor_patients, :patient, foreign_key: true
  end
end
