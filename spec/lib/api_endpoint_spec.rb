require 'spec_helper'
require_relative '../../lib/chaplin/api_endpoint'

class Chaplin

  describe ApiEndpoint do

    describe "#render" do

      let(:github_json) { File.open("spec/fixtures/github_root.json") }

      it "returns a hash of the response" do
        ApiEndpoint.configure("https://api.github.com", nil, nil)

        endpoint = ApiEndpoint.new(:get, '/', {})

        VCR.use_cassette('api_endpoint_spec', record: :once) do
          github_root = endpoint.render({})

          expected_hash = JSON.load(github_json)
          expect(github_root).to eq (expected_hash)
        end
      end

    end
  end

end
