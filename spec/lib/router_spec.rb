require 'spec_helper'

require_relative '../../lib/chaplin/builders/router'

module Chaplin::Builders
  describe Router do

    subject(:router) { Router.new(routes_declarations, {}, {}) }

    describe "#load_routes" do

      before do
        router.load_routes
      end

      let(:routes) { router.routes }

      describe "with a minimal routes file" do

        let(:routes_declarations) do
          { "routes" => { "GET /" => "index.html" } }
        end

        it "creates a page route" do
          expect(routes.values.first.template_path).to eq 'spec/fixtures/hello_chaplin/templates/index.html'
        end

      end

      describe "with a redirect" do
        let(:project_path) { "spec/fixtures/redirect" }

        it "creates a redirect response" do
          redirect = routes.values.first
          expect(redirect.redirect_path).to eq '/'
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
