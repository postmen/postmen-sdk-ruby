require 'spec_helper'

describe Postmen::Label do
  describe '#all' do
    it 'delegates method call to RateCollection' do
      expect(Postmen::RateCollection).to receive(:all)

      Postmen::Rate.all
    end
  end

  describe '#find' do
    it 'delegates method call to RateCollection' do
      expect(Postmen::RateCollection).to receive(:find).with('123')

      Postmen::Rate.find('123')
    end
  end

  describe '#create' do
    it 'delegates method call to RateCollection' do
      expect(Postmen::RateCollection).to receive(:create).with({})

      Postmen::Rate.create({})
    end
  end
end
