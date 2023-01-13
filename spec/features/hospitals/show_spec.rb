require 'rails_helper'

RSpec.describe 'hospitals show page' do
  before :each do
    @hospital = Hospital.create!(name: "St. Thomas")

    @doctor1 = Doctor.create!(name:'Jawana Wetzel', specialty: 'Heart', university: 'MTSU', hospital_id: @hospital.id)
    @doctor2 = Doctor.create!(name:'Tyran Ruffin', specialty: 'Ortho', university: 'UT', hospital_id: @hospital.id)
    @doctor3 = Doctor.create!(name:'The Good Doctor', specialty: 'Everything', university: 'Duke', hospital_id: @hospital.id)

    @patient1 = @doctor1.patients.create!(name: "Cynthia", age: 52)
    @patient2 = @doctor1.patients.create!(name: "Jamie", age: 62)
    @patient3 = @doctor2.patients.create!(name: "Kileigh", age: 25)
    @patient4 = @doctor2.patients.create!(name: "Lilo", age: 25)
    @patient5 = @doctor2.patients.create!(name: "Stitch", age: 25)

    @doctor2.patients << @patient2
    @doctor3.patients << [@patient1, @patient2, @patient3, @patient4, @patient5]

    visit hospital_path(@hospital)
  end

  it 'contains the hospitals name and its doctors' do
    expect(page).to have_content(@hospital.name)

    within("#doctors") do
      expect(page).to have_content(@doctor1.name)
      expect(page).to have_content(@doctor2.name)
      expect(page).to have_content(@doctor3.name)
    end
  end

  it 'contains a patient count for each doctor' do
    within("#doctor_#{@doctor1.id}") do
      expect(page).to have_content("Patients: #{@doctor1.patient_count}")
      expect(page).to have_content("Patients: 2")
    end

    within("#doctor_#{@doctor2.id}") do
      expect(page).to have_content("Patients: #{@doctor2.patient_count}")
      expect(page).to have_content("Patients: 4")
    end
  end

  it 'orders doctors by their patient count desc'  do
    within("#doctors") do
      expect(@doctor3.name).to appear_before(@doctor2.name)
      expect(@doctor2.name).to appear_before(@doctor1.name)

      expect(@doctor1.name).to_not appear_before(@doctor3.name)
      expect(@doctor1.name).to_not appear_before(@doctor2.name)
    end
  end
end