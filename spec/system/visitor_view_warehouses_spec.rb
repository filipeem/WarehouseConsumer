require 'rails_helper'

describe 'Visitor view warehouses' do
  it 'on home page' do
    # Arrange
    warehouses = File.read(Rails.root.join('spec', 'support', 'api_resources', 'warehouses.json'))
    r = Faraday::Response.new(status: 200, response_body: warehouses)
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses')
                                   .and_return(r)
    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'Maceió'
    expect(page).to have_content 'MCZ'
    expect(page).to have_content 'Salvador'
    expect(page).to have_content 'SSA'
  end

  it 'and the warehouse does not exist' do
    # Arrange
    warehouses = File.read(Rails.root.join('spec', 'support', 'api_resources', 'warehouses.json'))
    index_response = Faraday::Response.new(status: 200, response_body: warehouses)
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses')
                                   .and_return(index_response)

    show_response = Faraday::Response.new(status: 404, response_body: '{}')
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses/9999')
                                   .and_return(show_response)


    # Act
    visit warehouse_path(9999)

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content("Não foi possível carregar dados do galpão no momento")
  end


  it 'and render an error message if API is unavailable' do
    # Arrange
    r = Faraday::Response.new(status: 503, response_body: '{}')
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses')
                                   .and_return(r)

    # Act
    visit root_path

    # Assert
    expect(page).to have_content('Não foi possível carregar dados dos galpões')
  end

  it 'and the API is no longer responding' do
    # Arrange
    warehouses = File.read(Rails.root.join('spec', 'support', 'api_resources', 'warehouses.json'))
    index_response = Faraday::Response.new(status: 200, response_body: warehouses)
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses')
                                   .and_return(index_response)

    show_response = Faraday::Response.new(status: 500, response_body: '{}')
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses/1')
                                   .and_return(show_response)

    # Act
    visit root_path
    click_on 'Maceió'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content("Não foi possível carregar dados do galpão no momento")
  end


end
