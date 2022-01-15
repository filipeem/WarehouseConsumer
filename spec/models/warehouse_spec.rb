require 'rails_helper'

describe Warehouse do
  context '.all' do
    it 'should return all warehouses' do
      # Arrange
      warehouses_data = File.read(Rails.root.join('spec', 'support', 'api_resources', 'warehouses.json'))
      response = Faraday::Response.new(status: 200, response_body: warehouses_data)
      allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses')
                                     .and_return(response)
      # Act
      result = Warehouse.all

      # Assert
      expect(result.length).to eq 2
      expect(result.first.name).to eq 'Maceió'
      expect(result.first.code).to eq 'MCZ'
      expect(result.last.name).to eq 'Salvador'
      expect(result.last.code).to eq 'SSA'
    end

    it 'should return empty if theres no warehouse' do
      response = Faraday::Response.new(status: 200, response_body: '[]')
      allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses')
                                     .and_return(response)
      # Act
      result = Warehouse.all

      # Assert
      expect(result).to eq []
    end

    it 'should return nil if API is unavailable' do
      
      response = Faraday::Response.new(status: 500, response_body: '{}')
      allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses')
                                     .and_return(response)
      # Act
      result = Warehouse.all

      # Assert
      expect(result).to eq nil
    end
  end

  context '.find' do
    it 'should return warehouse details' do
      # Arrange
      warehouse_data = File.read(Rails.root.join('spec', 'support', 'api_resources', 'warehouse.json'))
      response = Faraday::Response.new(status: 200, response_body: warehouse_data)
      allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses/1')
                                     .and_return(response)
      # Act
      result = Warehouse.find(1)

      # Assert
      expect(result.name).to eq 'Maceió'
      expect(result.code).to eq 'MCZ'
      expect(result.description).to eq 'Ótimo galpão numa linda cidade'
      expect(result.city).to eq 'Maceió'
      expect(result.state).to eq 'AL'
      expect(result.postal_code).to eq '57050-000'
      
    end
  end
end
