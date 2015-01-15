require 'spec_helper'
require_relative '../../../lib/chaplin/parser/pages'

module Chaplin::Parser
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

      context "with a partial" do
        let(:raw_pages_data) do
          {
            "comments.html" => {
              "comments" => ["GET classes/comments/", {"article_id" => "{{id}}"}]
            },
            "article.html" => {
              "article" => ["GET classes/articles/{{id}}"],
              "comments" => "comments.html"
            }
          }
        end

        let(:comments_partial) do
          pages['article.html'].data['comments']
        end

        it "embeds the pages in a layout" do
          expect(comments_partial.data.keys).to eq ["comments"]
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
