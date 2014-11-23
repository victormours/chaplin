require 'spec_helper'
require_relative '../../lib/chaplin/pages'

class Chaplin
  describe Pages do

    let(:pages) { Pages.load(raw_pages_data, "project/path") }
    let(:raw_pages_data) do
      {
        "index.html" => {
          "articles" => ["GET classes/article"]
        }
      }
    end

    describe '.load' do
      let(:index) { pages["index.html"] }

      it 'loads all pages from json data' do
        expect(index.data.size).to eq 1
      end

      it "properly sets the templates path" do
        expect(index.template_path).to eq "project/path/templates/index.html"
      end

      context "with a layout" do
        let(:pages) do
          Pages.load(raw_pages_data, "project/path", "layout.html")
        end

        it "embeds the pages in a layout" do
          expect(pages['index.html'].template_path).to eq 'project/path/templates/layout.html'
        end
      end
    end

    describe '#[]' do
      context "when no page with such template name has ben defined" do
        it "returns a page with no attached data" do
          about = pages['about.html']
          expect(about.template_path).to eq 'project/path/templates/about.html'
          expect(about.data).to be_empty
        end
      end
    end


  end
end
