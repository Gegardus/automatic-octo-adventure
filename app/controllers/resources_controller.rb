# frozen_string_literal: true

class ResourcesController < ApplicationController
  authorized_when { current_user.admin? }

  def index
    @resources = Resource.all
  end

  def show
    @resource = Resource.find(params[:id])
  end

  def new
    @resource = Resource.new
  end

  def edit
    @resource = Resource.find(params[:id])
  end

  def create
    @resource = Resource.new(resource_params)

    @resource.save

    respond_with @resource
  end

  def update
    @resource = Resource.find(params[:id])

    @resource.update(resource_params)

    respond_with @resource
  end

  def destroy
    @resource = Resource.find(params[:id])

    @resource.delete

    respond_with @resource, location: resources_path
  end

  private

  def resource_params
    params.require(:resource).permit(:name, :content, :application_module)
  end
end
