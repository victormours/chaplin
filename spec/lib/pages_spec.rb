require 'spec_helper'
require_relative '../../lib/chaplin/pages'

class Chaplin
  describe Pages do

    describe '.load' do
      let(:raw_pages_data) do
        {
          "index.html" => { "articles" => ["GET classes/article"] },
          "article.html" => {
            "article" => ["GET classes/article/{{article_id}}", { "published" => true }]
          }
        }
      end

      it 'loads all pages from json data' do
        pages = Pages.load(raw_pages_data)

        index = pages["index.html"]
        expect(index.data.size).to eq 1
      end
    end

    describe '#[]' do
    end


  end
end
