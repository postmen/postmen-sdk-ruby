require 'spec_helper'

describe Postmen do
  after do
    Postmen.configure do |config|
      config.api_key = ''
      config.endpoint = nil
      config.failover = false
      config.region = 'sandbox'
    end
  end

  describe '#endpoint' do
    subject { described_class.endpoint }

    before do
      Postmen.configure do |config|
        config.region = region
      end
    end

    context 'with sandbox region' do
      let(:region) { 'sandbox' }

      it 'sets correct endpoint' do
        expect(subject).to eq('https://sandbox-api.postmen.com/v3')
      end
    end

    context 'with production region' do
      let(:region) { 'production' }

      it 'sets correct endpoint' do
        expect(subject).to eq('https://production-api.postmen.com/v3')
      end
    end

    context 'with custom endpoint' do
      let(:region) { 'production' }

      before do
        Postmen.configure do |config|
          config.endpoint = 'https://my-fancy-endpoint.com'
        end
      end

      it 'overwrites default endpoint uri' do
        expect(subject).to eq('https://my-fancy-endpoint.com')
      end
    end

    context 'on failover' do
      let(:region) { 'sandbox' }

      before do
        Postmen.failover!
      end

      it 'sets failover URL' do
        expect(subject).to eq('https://sandbox-api.postmen.net/v3')
      end
    end
  end
end
