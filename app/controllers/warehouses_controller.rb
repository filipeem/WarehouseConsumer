class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
    if @warehouse.nil?
      
      redirect_to root_path
      flash[:alert] = 'Não foi possível carregar dados do galpão no momento'
    end
  end

end