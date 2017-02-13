require 'spec_helper'

describe Postmen::CreateLabelQuery do
  subject { Postmen::CreateLabelQuery.new(params).to_query[:json] }
  let(:service_type) { 'ups' }
  let(:shipper_account) { { id: 'ea892cab-2f2b-4c1f-9294-95fd8a912662' } }
  let(:shipment) { {} }
  let(:default_params) { { service_type: service_type, shipper_account: shipper_account, shipment: shipment } }

  context 'without required params' do
    context 'without service_type' do
      let(:params) { default_params.tap { |h| h.delete(:service_type) } }

      it 'raises TypeError' do
        expect { subject }.to raise_error(Dry::Struct::Error)
      end
    end

    context 'without shipper_account' do
      let(:params) { default_params.tap { |h| h.delete(:shipper_account) } }

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
      it 'passes default params to th query' do
        expect(subject).to eq(default_params)
      end
    end
  end
end
