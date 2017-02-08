require 'spec_helper'

describe Postmen::LabelQuery do
  subject { Postmen::LabelQuery.new(params).to_query[:params] }
  let(:params) { {} }

  context 'without params' do
    it 'returns empty hash' do
      expect(subject).to eq({})
    end
  end

  describe 'shipper_account_id' do
    let(:params) { { shipper_account_id: '123' } }

    it 'sets shipper_account_id in query hash' do
      expect(subject).to eq(shipper_account_id: '123')
    end
  end

  describe 'status' do
    context 'with valid status' do
      let(:params) { { status: 'cancelled' } }

      it 'sets staus in query hash' do
        expect(subject).to eq(status: 'cancelled')
      end
    end

    context 'with invalid status' do
      let(:params) { { status: 'INVALID_STATUS' } }

      it 'raises error' do
        expect { subject }.to raise_error(Dry::Struct::Error)
      end
    end
  end

  describe 'created_at_min' do
    context 'with DateTime object' do
      let(:params) { { created_at_min: DateTime.parse('2017-02-02 20:00') } }

      it 'parses it to correct format' do
        expect(subject).to eq(created_at_min: '2017-02-02T20:00:00+00:00')
      end
    end
  end

  describe 'created_at_max' do
    context 'with DateTime object' do
      let(:params) { { created_at_max: DateTime.parse('2017-02-02 20:00') } }

      it 'parses it to correct format' do
        expect(subject).to eq(created_at_max: '2017-02-02T20:00:00+00:00')
      end
    end
  end

  describe 'tracking_numbers' do
    context 'with array of numbers' do
      let(:params) { { tracking_numbers: [1, 2, 3] } }

      it 'concatenates numbers' do
        expect(subject).to eq(tracking_numbers: '1,2,3')
      end
    end

    context 'with concatenated string' do
      let(:params) { { tracking_numbers: '1,2,3' } }
      it 'passes them to query' do
        expect(subject).to eq(tracking_numbers: '1,2,3')
      end
    end
  end
end
