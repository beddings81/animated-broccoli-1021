require 'rails_helper'

RSpec.describe 'patients index page' do
  before :each do
    @hospital = Hospital.create!(name: "St. Thomas")

    @doctor1 = Doctor.create!(name:'Jawana Wetzel', specialty: 'Heart', university: 'MTSU', hospital_id: @hospital.id)
    @doctor2 = Doctor.create!(name:'Tyran Ruffin', specialty: 'Ortho', university: 'UT', hospital_id: @hospital.id)

    @patient1 = @doctor1.patients.create!(name: "Cynthia", age: 52)
    @patient2 = @doctor1.patients.create!(name: "Jamie", age: 62)
    @patient3 = @doctor2.patients.create!(name: "Kileigh", age: 25)
    @patient4 = @doctor2.patients.create!(name: "Alex", age: 17)
    @patient5 = @doctor2.patients.create!(name: "Drake", age: 19)

    visit patients_path
  end

  it 'contains the names o all adult patients' do
    expect(page).to have_content(@patient1.name)
    expect(page).to have_content(@patient2.name)
    expect(page).to have_content(@patient3.name)
    expect(page).to have_content(@patient5.name)

    expect(page).to_not have_content(@patient4.name)
  end

  it 'list the patient names alphabetically' do
    expect(@patient1.name).to appear_before(@patient5.name)
    expect(@patient5.name).to appear_before(@patient2.name)
    expect(@patient2.name).to appear_before(@patient3.name)

    expect(@patient2.name).to appear_before(@patient1.name)
    expect(@patient3.name).to appear_before(@patient5.name)
  end
end