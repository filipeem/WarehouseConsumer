class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
    if @warehouse.nil?
      
      redirect_to root_path
      flash[:alert] = 'Não foi possível carregar dados do galpão no momento'
    end
  end

  def new
  end

  def create
    warehouse_params = params.permit(:name, :code, :description, :postal_code, :address, :city, :state, :total_area, :useful_area)
    
    @warehouse = Warehouse.save(warehouse_params)
    if @warehouse.nil?
      flash.now[:alert] = 'Não foi possível gravar o galpão'
      render 'new'
    else
      redirect_to warehouse_path(@warehouse["id"]), notice: 'Galpão registrado com sucesso'
    end                               
  end

end