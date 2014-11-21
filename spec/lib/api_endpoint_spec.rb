require 'spec_helper'
require_relative '../../lib/chaplin/api_endpoint'

class Chaplin

  describe ApiEndpoint do

    describe "#render" do

      it "returns a hash of the response" do

        ApiEndpoint.configure("http://api.github.com", nil, nil)

        endpoint = ApiEndpoint.new(:get, '/', {})
        VCR.use_cassette('api_endpoint_spec', record: :all) do
          endpoint.render({})
        end
      end
    end
  end

end
