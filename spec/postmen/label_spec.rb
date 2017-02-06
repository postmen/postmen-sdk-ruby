require 'spec_helper'

describe Postmen::Label do
  describe '#all' do
    it 'delegates method call to LabelCollection' do
      expect(Postmen::LabelCollection).to receive(:all)

      Postmen::Label.all
    end
  end
end
