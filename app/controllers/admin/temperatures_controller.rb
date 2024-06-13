class Admin::TemperaturesController < ApplicationController

  def index
    @temperature = Temperature.new
    @temperatures = Temperature.all
  end

  def create
    @temperature = Temperature.new(temperature_params)
    if @temperature.save
      redirect_to admin_temperatures_path
    else
      @temperatures = Temperature.all
      render :index
    end
  end

  def edit
    @temperature = Temperature.find(params[:id])
  end

  def update
    @temperature = Temperature.find(params[:id])
    if @temperature.update(temperature_params)
      redirect_to admin_temperatures_path
    else
      render :edit
    end
  end

  def destroy
    temperature = Temperature.find(params[:id])
    temperature.destroy
    redirect_to admin_temperatures_path
  end

  private

  def temperature_params
    params.require(:temperature).permit(:temperature_name)
  end
end
