require 'spec_helper'
require_relative '../../lib/chaplin/router'

describe Chaplin::Router do

  describe "#template_for" do

    let(:router) { described_class.new("spec/fixtures/routes.json") }
    let(:about_request) { double(request_method: "GET", path: "/about") }

    it "returns the template name" do
      template = router.template_for(about_request)
      expect(template).to eq "about.html"
    end

  end

end
