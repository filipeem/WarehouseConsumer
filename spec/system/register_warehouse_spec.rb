require 'rails_helper'

describe 'visitor register new warehouse' do
  it 'successfully' do
    #Arrange
    warehouses = File.read(Rails.root.join('spec', 'support', 'api_resources', 'warehouses.json'))
    index_response = Faraday::Response.new(status: 200, response_body: warehouses)
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses')
                                   .and_return(index_response)
    warehouse = File.read(Rails.root.join('spec', 'support', 'api_resources', 'warehouse_create.json'))
    response = Faraday::Response.new(status: 201, response_body: warehouse)
    allow(Faraday).to receive(:post).with('http://localhost:3000/api/v1/warehouses/')
                                   .and_return(response)
    
    r2 = Faraday::Response.new(status: 200, response_body: warehouse)
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses/3')
                                   .and_return(r2)
    #Act
    visit root_path
    click_on 'Cadastrar Galpão'
    fill_in 'Nome', with: 'Porto Alegre'
    fill_in 'Código', with: 'POA'
    fill_in 'Endereço', with: 'Av dos Estados'
    fill_in 'Cidade', with: 'Porto Alegre'
    fill_in 'Estado', with: 'RS'
    fill_in 'CEP', with: '90050-000'
    fill_in 'Descrição', with: 'Galpão do Aeroporto'
    fill_in 'Área Total', with: '10000'
    fill_in 'Área Útil', with: '8000'
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Porto Alegre'
    expect(page).to have_content 'POA'
    expect(page).to have_content 'Galpão do Aeroporto'
    expect(page).to have_content 'RS'
    expect(page).to have_content '90050-000'
    expect(page).to have_content '10000'
    expect(page).to have_content '8000'
  end

end