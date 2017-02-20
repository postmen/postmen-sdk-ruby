require 'spec_helper'

describe Postmen::Shipment do
  subject { Postmen::Shipment.new(params) }
  let(:params) do
    {
      'ship_from': {
        'contact_name': 'Nottingham Inc.',
        'company_name': 'Nottingham Inc.',
        'street1': '2511 S. Main St.',
        'city': 'Grove',
        'state': 'OK',
        'postal_code': '74344',
        'country': 'HKG',
        'phone': '1-403-504-5496',
        'email': 'test@test.com',
        'type': 'business'
      },
      'ship_to': {
        'contact_name': 'Rick McLeod (RM Consulting)',
        'street1': '71 Terrace Crescent NE',
        'street2': 'This is the second streeet',
        'city': 'Medicine Hat',
        'state': 'Alberta',
        'postal_code': 'T1C1Z9',
        'country': 'CAN',
        'phone': '1-403-504-5496',
        'email': 'test@test.test',
        'type': 'residential'
      },
      'parcels': [
        {
          'description': 'Food XS',
          'box_type': 'custom',
          'weight': {
            'value': 2,
            'unit': 'kg'
          },
          'dimension': {
            'width': 20,
            'height': 40,
            'depth': 40,
            'unit': 'cm'
          },
          'items': [
            {
              'description': 'Food Bar',
              'origin_country': 'USA',
              'quantity': 2,
              'price': {
                'amount': 3,
                'currency': 'USD'
              },
              'weight': {
                'value': 0.6,
                'unit': 'kg'
              },
              'sku': 'Epic_Food_Bar',
              'hs_code': '11111111'
            }
          ]
        }
      ]
    }
  end

  context 'with correct params' do
    it 'sets correct ship_from address' do
      expect(subject.to_hash[:ship_from]).to eq(params[:ship_from])
    end

    it 'sets correct ship_to address' do
      expect(subject.to_hash[:ship_to]).to eq(params[:ship_to])
    end

    it 'sets correct items' do
      expect(subject.to_hash[:items]).to eq(params[:items])
    end
  end
end
