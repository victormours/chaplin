require 'spec_helper'
require_relative '../../../lib/chaplin/responses/redirect'

module Chaplin::Responses

  describe Redirect do


    describe "#execute" do

      context "with a session hash" do

        let(:redirect) do
          described_class.new('/', {})
        end

        let(:server) { double(redirect: true) }

        it "writes the session to the server" do
          redirect.execute({}, server)

        end

      end

    end
  end
end


