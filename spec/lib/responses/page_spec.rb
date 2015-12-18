require 'spec_helper'
require_relative '../../../lib/chaplin/responses/page'

class Chaplin
  RSpec.describe Responses::Page do

    describe "lazy rendering" do

      it "doesn't render things it doesn't have to" do
        expect(partial).not_to receive(:render)
        page.render({})
      end

      it "renders properly" do
        expect(page.render({ name: 'Bob' })).to eq "Hello Bob\nThis is cool\n\n"
      end

      let(:page) do
        described_class.new("spec/fixtures/index.html", { about: partial })
      end

      let(:partial) do
        described_class.new("spec/fixtures/about.html", {})
      end
    end

  end
end


