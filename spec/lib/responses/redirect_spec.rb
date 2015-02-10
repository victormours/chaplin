require 'spec_helper'
require_relative '../../../lib/chaplin/responses/redirect'

module Chaplin::Responses

  describe Redirect do


    describe "#execute" do

      context "with a session hash" do

        let(:redirect) do
          described_class.new('/', api_requests_hash, cookie_hash)
        end

        let(:api_requests_hash) do
          {
            login: double(render: { username: 'Bob' })
          }
        end

        let(:cookie_hash) do
          {
            username: '{{login.username}}'
          }
        end

        let(:server) { double(redirect: true, cookies: {}) }

        it "writes the session to the server" do
          expect(server).to receive(:cookies)
          redirect.execute({}, server)

        end

      end

    end
  end
end


