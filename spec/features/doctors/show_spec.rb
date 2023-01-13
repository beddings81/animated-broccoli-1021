require 'rails_helper'

RSpec.describe 'doctors show page' do
  before :each do
    @hospital = Hospital.create!(name: "St. Thomas")

    @doctor1 = Doctor.create!(name:'Jawana Wetzel', specialty: 'Heart', university: 'MTSU', hospital_id: @hospital.id)
    @doctor2 = Doctor.create!(name:'Tyran Ruffin', specialty: 'Ortho', university: 'UT', hospital_id: @hospital.id)

    @patient1 = @doctor1.patients.create!(name: "Cynthia", age: 52)
    @patient2 = @doctor1.patients.create!(name: "Jamie", age: 62)
    @patient3 = @doctor2.patients.create!(name: "Kileigh", age: 25)

    @doctor2.patients << @patient2

    visit doctor_path(@doctor1)
  end

  it 'contains the doctors name, specialty, and university' do
    expect(page).to have_content(@doctor1.name)
    expect(page).to have_content("Specialty: #{@doctor1.specialty}")
    expect(page).to have_content("University: #{@doctor1.university}")

    expect(page).to_not have_content(@doctor2.name)
    expect(page).to_not have_content("Specialty: #{@doctor2.specialty}")
    expect(page).to_not have_content("University: #{@doctor2.university}")
  end

  it 'contains a doctors hospital and their patients' do
    within("#hospital") do
      expect(page).to have_content("Hospital: #{@hospital.name}")
    end

    within('#patients') do
      expect(page).to have_content(@patient1.name)
      expect(page).to have_content(@patient2.name)
      expect(page).to_not have_content(@patient3.name)
    end
  end

  it 'contains a button next to each patient to remove that patient from that docotrs caseload' do
    within('#patients') do
      expect(page).to have_content(@patient1.name)
      expect(page).to have_content(@patient2.name)
    end

    within("#patient_#{@patient1.id}") do
      expect(page).to have_button("Remove")
    end
    
    within("#patient_#{@patient2.id}") do
      expect(page).to have_button("Remove")

      click_button "Remove"
    end

    expect(current_path).to eq(doctor_path(@doctor1))

    within('#patients') do
      expect(page).to_not have_content(@patient2.name)
    end

    visit doctor_path(@doctor2)

    within('#patients') do
      expect(page).to have_content(@patient2.name)
    end
  end
end