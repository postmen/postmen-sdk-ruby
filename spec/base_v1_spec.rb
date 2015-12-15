require 'spec_helper'

describe Postmen::V1::Base do
  let(:http_verb_method) { 'get' }
  let(:end_point)        { 'trackings' }
  let(:params)           { { courier: 'usps' } }
  let(:body)             { { emails: ['me@example.com'] } }
  subject                { described_class.new(http_verb_method, end_point, params, body) }

  its(:body)             { should(eq(body)) }
  its(:params)           { should(eq(params)) }
  its(:end_point)        { should(eq(end_point)) }
  its(:http_verb_method) { should(eq(http_verb_method)) }

  describe ".call" do
    let(:body)     { { emails: '', smses: '' } }
    let(:response) { double(raw_body: '{}') }
    let(:request)  { double }
    before         {
		#HTTPI.logger.stub(:warn)
	}

    it 'validates' do
      #HTTPI.logger.should_receive(:warn).with("the emails field should be an array").once
      #HTTPI.logger.should_receive(:warn).with('the smses field should be an array').once

      #HTTPI.should_receive(:send).with(:get, kind_of(HTTPI::Request)).and_return(response)
      subject.call
    end

    it 'create valid request' do

      subject.call
    end
  end
end
