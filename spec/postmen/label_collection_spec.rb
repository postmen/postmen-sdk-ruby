require 'spec_helper'

describe Postmen::LabelCollection do
  describe '#all' do
    before do
      Postmen.configure do |config|
        config.api_key = api_key
      end

      stub_labels_request!
    end

    subject { Postmen::LabelCollection.all }

    context 'without labels' do
      let(:api_key) { 'CORRECT_KEY_NO_LABELS' }

      it 'returns empty array' do
        expect(subject.to_a).to eq([])
      end
    end

    context 'with labels' do
      let(:api_key) { 'CORRECT_KEY' }
      let(:labels) { JSON.parse(responses('labels', 'success'), symbolize_names: true)[:data][:labels] }
      let(:first_label) { Postmen::Label.new(labels[0]) }
      let(:second_label) { Postmen::Label.new(labels[1]) }

      it 'wraps labels into collection of Label models' do
        expect(subject[0]).to eq(first_label)
        expect(subject[1]).to eq(second_label)
      end
    end
  end

  describe '#find' do
    before do
      stub_label_request!
    end

    subject { Postmen::LabelCollection.find(id) }

    context 'when Label does not exist' do
      let(:id) { '00000000-0000-0000-0000-000000000000' }

      it 'raises ResourceNotFound error' do
        expect { subject }.to raise_error(Postmen::ResourceNotFound)
      end
    end

    context 'when Label exists' do
      let(:id) { 'ee1af83b-6aa9-40ad-b60f-3b7a17cf78ce' }
      let(:raw_response) { JSON.parse(responses('labels', 'single_existing'), symbolize_names: true)[:data] }
      let(:label) { Postmen::Label.new(raw_response) }

      it 'returns instance of Label' do
        expect(subject).to eq(label)
      end
    end
  end
end
