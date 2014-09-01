require 'spec_helper'
require_relative '../../lib/chaplin/api_client'

describe Chaplin::APIClient do

  let(:api_client) { described_class.new('localhost:8080') }
  let(:request) { double }
  let(:http_method) { 'GET' }
  let(:path) { '/profile' }

  describe '#forward' do
    it "returns the body of the request to the API" do
    end

  end

end
