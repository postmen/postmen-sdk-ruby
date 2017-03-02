require 'spec_helper'

describe Postmen::CreateRateQuery do
  subject { Postmen::CreateRateQuery.new(params).to_query[:json] }
  let(:shipment) do
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
  let(:shipper_account) { { id: 'ea892cab-2f2b-4c1f-9294-95fd8a912662' } }
  let(:shipper_accounts) { [shipper_account] }

  let(:default_params) { { shipment: shipment, shipper_accounts: shipper_accounts } }

  context 'without required params' do
    context 'without shipper_accounts' do
      let(:params) { default_params.tap { |h| h.delete(:shipper_accounts) } }

      it 'raises TypeError' do
        expect { subject }.to raise_error(Dry::Struct::Error)
      end
    end

    context 'without shipment' do
      let(:params) { default_params.tap { |h| h.delete(:shipment) } }

      it 'raises TypeError' do
        expect { subject }.to raise_error(Dry::Struct::Error)
      end
    end
  end

  context 'with valid params' do
    context 'without optional params' do
      let(:params) { default_params }
      it 'passes default params to the query' do
        expect(subject).to eq(default_params)
      end
    end
  end
end
