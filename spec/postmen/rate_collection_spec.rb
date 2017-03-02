require 'spec_helper'

describe Postmen::RateCollection do
  describe '#all' do
    before do
      Postmen.configure do |config|
        config.api_key = api_key
      end

      stub_rates_request!
    end

    subject { Postmen::RateCollection.all }

    context 'without rates' do
      let(:api_key) { 'CORRECT_KEY_NO_RATES' }

      it 'returns empty array' do
        expect(subject.to_a).to eq([])
      end
    end

    context 'with rates' do
      let(:api_key) { 'CORRECT_KEY' }
      let(:rates) { JSON.parse(responses('rates', 'success'), symbolize_names: true)[:data][:rates] }
      let(:first_rate) { Postmen::Rate.new(rates[0]) }
      let(:second_rate) { Postmen::Rate.new(rates[1]) }

      it 'wraps rates into collection of Rate models' do
        expect(subject[0]).to eq(first_rate)
        expect(subject[1]).to eq(second_rate)
      end
    end
  end

  describe '#find' do
    before do
      stub_rate_request!
    end

    subject { Postmen::RateCollection.find(id) }

    context 'when Rate does not exist' do
      let(:id) { '00000000-0000-0000-0000-000000000000' }

      it 'raises ResourceNotFound error' do
        expect { subject }.to raise_error(Postmen::ResourceNotFound)
      end
    end

    context 'when Rate exists' do
      let(:id) { 'ee1af83b-6aa9-40ad-b60f-3b7a17cf78ce' }
      let(:raw_response) { JSON.parse(responses('rates', 'single_existing'), symbolize_names: true)[:data] }
      let(:rate) { Postmen::Rate.new(raw_response) }

      it 'returns instance of Rate' do
        expect(subject).to eq(rate)
      end
    end
  end
end
