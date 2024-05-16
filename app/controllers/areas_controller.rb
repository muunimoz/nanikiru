class AreasController < ApplicationController
  
  def index
    @area = Area.new
    @areas = Area.all
  end
  
  def create
    area = Area.new(area_params)
    area.save
    redirect_to areas_path
  end
  
  def edit
    @area = Area.find(params[:id])
  end
  
  def update
    area = Area.find(params[:id])
    area.update(area_params)
    redirect_to areas_path
  end
  
  def destroy
    area = Area.find(params[:id])
    area.destroy
    redirect_to areas_path
  end
  
  private
  
  def area_params
    params.require(:area).permit(:area_name)
  end
end
