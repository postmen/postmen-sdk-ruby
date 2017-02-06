require 'spec_helper'

describe Postmen::LabelCollection do
  before do
    Postmen.configure do |config|
      config.api_key = api_key
    end

    stub_labels_request!
  end

  describe '#all' do
    subject { Postmen::LabelCollection.all }

    context 'without labels' do
      let(:api_key){ "CORRECT_KEY_NO_LABELS" }

      it 'returns empty array' do
        expect(subject.to_a).to eq([])
      end
    end

    context 'with labels' do
      let(:api_key){ "CORRECT_KEY" }
      let(:labels){ JSON.parse(responses('labels', 'success'), symbolize_names: true)[:data][:labels] }
      let(:first_label){ Postmen::Label.new(labels[0]) }
      let(:second_label){ Postmen::Label.new(labels[1]) }

      it 'wraps labels into collection of Label models' do
        expect(subject[0]).to eq(first_label)
        expect(subject[1]).to eq(second_label)
      end

    end
  end
end
