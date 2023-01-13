require 'rails_helper'

RSpec.describe 'hospitals show page' do
  before :each do
    @hospital = Hospital.create!(name: "St. Thomas")

    @doctor1 = Doctor.create!(name:'Jawana Wetzel', specialty: 'Heart', university: 'MTSU', hospital_id: @hospital.id)
    @doctor2 = Doctor.create!(name:'Tyran Ruffin', specialty: 'Ortho', university: 'UT', hospital_id: @hospital.id)

    @patient1 = @doctor1.patients.create!(name: "Cynthia", age: 52)
    @patient2 = @doctor1.patients.create!(name: "Jamie", age: 62)
    @patient3 = @doctor2.patients.create!(name: "Kileigh", age: 25)
    @patient4 = @doctor2.patients.create!(name: "Lilo", age: 25)
    @patient5 = @doctor2.patients.create!(name: "Stitch", age: 25)

    @doctor2.patients << @patient2

    visit hospital_path(@hospital)
  end

  it 'contains the hospitals name and its doctors' do
    expect(page).to have_content(@hospital.name)

    within("#doctors") do
      expect(page).to have_content(@doctor1.name)
      expect(page).to have_content(@doctor2.name)
    end
  end

  it 'contains a patient count for each doctor' do
    save_and_open_page
    within("#doctor_#{@doctor1.id}") do
      expect(page).to have_content("Patients: #{@doctor1.patient_count}")
      expect(page).to have_content("Patients: 2")
    end

    within("#doctor_#{@doctor2.id}") do
      expect(page).to have_content("Patients: #{@doctor2.patient_count}")
      expect(page).to have_content("Patients: 4")
    end
  end
end