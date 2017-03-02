require 'spec_helper'

describe Postmen::Types::Address do
  subject { Postmen::Types::Address.new(params) }

  context 'with correct attributes' do
    context 'with country only' do
      let(:params) { { country: 'POL' } }

      it 'creates Address resource' do
        expect { subject }.not_to raise_error
      end

      it 'returns propper hash' do
        expect(subject.to_hash).to eq(country: 'POL')
      end
    end

    context 'with additional params' do
      let(:params) { { country: 'POL', city: 'Warsaw', postal_code: '12-345', street1: 'Wiejska' } }
      it 'passes them to the hash' do
        expect(subject.to_hash).to eq(country: 'POL', city: 'Warsaw', postal_code: '12-345', street1: 'Wiejska')
      end
    end
  end

  context 'with incorrect attributes' do
  end
end
