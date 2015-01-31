require 'spec_helper'

require_relative '../../../lib/chaplin/parser/router'

module Chaplin::Parser
  describe Router do

    subject(:router) do
      Router.new(routes_declarations, pages, redirects)
    end

    let(:routes_declarations) do
      { "GET /" => "index.html" }
    end

    let(:pages) do
      {'index.html' => index_page }
    end
    let(:index_page) { double }

    let(:redirects) do
      { 'create_post' => post_redirect }
    end
    let(:post_redirect) { double }

    describe "#routes" do

      let(:routes) { router.routes }

      describe "with a minimal routes file" do

        it "creates a page route" do
          expect(routes.values.first).to eq index_page
        end

      end

      describe "with a redirect" do

        let(:routes_declarations) do
          {
            "GET /redirection" => "redirect create_post"
          }
        end

        it "creates a redirect response" do
          expect(routes.values.first).to eq post_redirect
        end
      end

    end
  end

end
