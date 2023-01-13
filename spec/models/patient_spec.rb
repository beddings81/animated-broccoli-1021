require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe 'relationships' do
    it { should have_many :doctor_patients }
    it { should have_many(:doctors).through(:doctor_patients) }
  end

  before :each do
    @hospital = Hospital.create!(name: "St. Thomas")

    @doctor1 = Doctor.create!(name:'Jawana Wetzel', specialty: 'Heart', university: 'MTSU', hospital_id: @hospital.id)
    @doctor2 = Doctor.create!(name:'Tyran Ruffin', specialty: 'Ortho', university: 'UT', hospital_id: @hospital.id)

    @patient1 = @doctor1.patients.create!(name: "Cynthia", age: 52)
    @patient2 = @doctor1.patients.create!(name: "Jamie", age: 62)
    @patient3 = @doctor2.patients.create!(name: "Kileigh", age: 25)
    @patient4 = @doctor2.patients.create!(name: "Alex", age: 17)
    @patient5 = @doctor2.patients.create!(name: "Drake", age: 19)

    @doctor2.patients << @patient2
  end

  describe 'class methods' do
    describe '#adult_patients' do
      it 'returns all patients over the age of 18' do
        expect(Patient.adult_patients).to eq([@patient1, @patient2, @patient3, @patient5])
        expect(Patient.adult_patients.size).to eq(4)
        expect(Patient.adult_patients).to_not include(@patient4)
      end
    end

    describe '#sort_alpha' do
      it 'list all patients alphabetically' do
        expect(Patient.sort_alpha).to eq([@patient4, @patient1, @patient5, @patient2, @patient3])
      end
    end
  end
end