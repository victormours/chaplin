require 'spec_helper'
require_relative '../../lib/chaplin/router'

describe Chaplin::Router do

  let(:router) { described_class.new("spec/fixtures/routes.json") }
  let(:about_request) { double(request_method: "GET", path: "/about") }

  describe "#template_for" do
    it "returns the template name" do
      template = router.template_for(about_request)
      expect(template).to eq "about.html"
    end

  end

  describe "#data_for" do

    let(:profile_request) { double(request_method: "GET", path: "/profile") }

    it "returns a hash of names and endpoints" do
      data = router.data_for(profile_request)
      expect(data).to eq({ "user" => Endpoint.new("GET", "/user.json") })
    end
  end

end
