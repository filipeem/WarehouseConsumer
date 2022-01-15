class Warehouse
  attr_accessor :id, :name, :code, :description, :address, :postal_code, :city, :state, :total_area, :useful_area

  def initialize(id:, name:, code:, description:, address:, postal_code:, city:, state:, total_area:, useful_area:)
    @id = id
    @name = name
    @code = code
    @description = description
    @address = address
    @postal_code = postal_code
    @city = city
    @state = state
    @total_area = total_area
    @useful_area = useful_area
  end

  def self.all
    api_domain = Rails.configuration.apis["warehouses_api"]
    response = Faraday.get("#{api_domain}/api/v1/warehouses")
    result = []

    if response.status == 200
      warehouses = JSON.parse(response.body)
      warehouses.each do |w|
        result << Warehouse.new(id: w["id"], name: w["name"], code: w["code"], 
                                description: w["description"], address: w["address"],
                                postal_code: w["postal_code"], city: w["city"], state: ["state"],
                                total_area: w["total_area"], useful_area: w["useful_area"])
      end
    else
      return nil
    end

    return result
  end

  def self.find(id)
    api_domain = Rails.configuration.apis["warehouses_api"]
    response = Faraday.get("#{api_domain}/api/v1/warehouses/#{id}")

    if response.status == 200
      w = JSON.parse(response.body)
      
      result = Warehouse.new(id: w["id"], name: w["name"], code: w["code"], 
                              description: w["description"], address: w["address"],
                              postal_code: w["postal_code"], city: w["city"], state: w["state"],
                              total_area: w["total_area"], useful_area: w["useful_area"])
    else
      return nil
    end

    return result
  end
end
