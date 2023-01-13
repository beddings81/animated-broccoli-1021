require 'rails_helper'

RSpec.describe Doctor do
  it { should belong_to :hospital }
  it { should have_many :doctor_patients }
  it { should have_many(:patients).through(:doctor_patients) }

  before :each do
    @hospital = Hospital.create!(name: "St. Thomas")

    @doctor1 = Doctor.create!(name:'Jawana Wetzel', specialty: 'Heart', university: 'MTSU', hospital_id: @hospital.id)
    @doctor2 = Doctor.create!(name:'Tyran Ruffin', specialty: 'Ortho', university: 'UT', hospital_id: @hospital.id)

    @patient1 = @doctor1.patients.create!(name: "Cynthia", age: 52)
    @patient2 = @doctor1.patients.create!(name: "Jamie", age: 62)
    @patient3 = @doctor2.patients.create!(name: "Kileigh", age: 25)

    @doctor2.patients << @patient2
  end

  describe 'instance methods' do
    describe '#patient_count' do
      it 'returns the counts of patients for a doctor' do
        expect(@doctor1.patient_count).to eq(2)
        expect(@doctor2.patient_count).to eq(2)
      end
    end
  end
end
