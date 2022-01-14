require 'rails_helper'

describe 'Visitor view warehouse details' do
  it 'thru home page' do
    # Arrange
    warehouses = File.read(Rails.root.join('spec', 'support', 'api_resources', 'warehouses.json'))
    r1 = Faraday::Response.new(status: 200, response_body: warehouses)
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses')
                                   .and_return(r1)
    warehouse = File.read(Rails.root.join('spec', 'support', 'api_resources', 'warehouse.json'))
    r2 = Faraday::Response.new(status: 200, response_body: warehouse)
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses/')
                                   .and_return(r2)
    # Act
    visit root_path
    click_link 'Maceió'
    
    # Assert
    expect(page).to have_content 'Maceió'
    expect(page).to have_content 'MCZ'
    expect(page).to have_content 'Ótimo galpão numa linda cidade'
    expect(page).to have_content 'AL'
    expect(page).to have_content '57050-000'
    expect(page).to have_content '10000'
    expect(page).to have_content '8000'
  end
end