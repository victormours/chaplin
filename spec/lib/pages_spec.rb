require 'spec_helper'
require_relative '../../lib/chaplin/pages'

class Chaplin
  describe Pages do

    describe '.load' do
      let(:raw_pages_data) do
        {
          "index.html" => {
            "articles" => ["GET classes/article"]
          }
        }
      end

      it 'loads all pages from json data' do
        pages = Pages.load(raw_pages_data)

        index = pages["index.html"]
        expect(index.data.size).to eq 1
      end

      context "with a layout" do
        it "embeds the pages in a layout" do
          pages = Pages.load(raw_pages_data, "layout.html")
          expect(pages['index.html'].template_path).to eq 'layout.html'
        end
      end
    end

    describe '#[]' do
    end


  end
end
