# frozen_string_literal: true

class ApplicantResourcesController < ApplicationController
  authorized_when { current_user.applicant? }

  def index
    @application_modules = ApplicationModules.new(applicant: current_user)
    @resources = Resource.all
  end
end
