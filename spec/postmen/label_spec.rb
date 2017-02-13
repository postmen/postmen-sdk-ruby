require 'spec_helper'

describe Postmen::Label do
  describe '#all' do
    it 'delegates method call to LabelCollection' do
      expect(Postmen::LabelCollection).to receive(:all)

      Postmen::Label.all
    end
  end

  describe '#create' do
    before do
      stub_label_creation_request!
    end

    subject { Postmen::Label.create(params) }

    context 'with valid params' do
      let(:customs) do
        {
          'billing': {
            'paid_by': 'recipient'
          },
          'terms_of_trade': 'ddu',
          'purpose': 'gift'
        }
      end

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
      let(:shipper_account) { { id: '0f55736c-fde6-4b65-8955-907729a10cbc' } }
      let(:service_type) { 'hong-kong-post_air_parcel' }
      let(:params) do
        {
          customs: customs,
          shipment: shipment,
          service_type: service_type,
          shipper_account: shipper_account
        }
      end

      it 'creates new label' do
        expect(subject.class).to eq(Postmen::Label)
      end

      it 'sets ID' do
        expect(subject.id).to eq('ee1af83b-6aa9-40ad-b60f-3b7a17cf78ce')
      end

      it 'uses CreateLabelQuery when creating a Label' do
        expect(Postmen::CreateLabelQuery).to receive(:new).with(params).and_call_original

        subject
      end

      it 'transforms CreateLabelQuery to_query when creating a Label' do
        expect_any_instance_of(Postmen::CreateLabelQuery).to receive(:to_query).and_call_original

        subject
      end
    end
  end
end
