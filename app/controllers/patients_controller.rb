class PatientsController < ApplicationController
  def index
    @patients = Patient.adult_patients
  end
end