
require 'spec_helper'

require_relative '../../lib/chaplin/router'

class Chaplin
  describe Router do

    subject(:router) { Router.new(project_path) }

    describe "#load_routes" do

      before do
        router.load_routes
      end

      let(:routes) { router.routes }

      describe "with a minimal routes file" do

        let(:project_path) { "spec/fixtures/hello_chaplin" }

        it "creates a page route" do
          route = routes.first
        end

      end
      describe "with complex routes" do
        let(:project_path) { "spec/fixtures/blog" }

        it "returns a hash of all the routes" do
          expect(routes.count).to eq 5
        end
      end


    end
  end

end
