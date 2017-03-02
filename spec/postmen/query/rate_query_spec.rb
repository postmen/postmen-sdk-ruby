require 'spec_helper'

describe Postmen::RateQuery do
  subject { Postmen::RateQuery.new(params).to_query[:params] }
  let(:params) { {} }

  context 'without params' do
    it 'returns empty hash' do
      expect(subject).to eq({})
    end
  end

  describe 'status' do
    context 'with valid status' do
      let(:params) { { status: 'calculated' } }

      it 'sets staus in query hash' do
        expect(subject).to eq(status: 'calculated')
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
end
