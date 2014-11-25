require 'spec_helper'

require_relative '../../lib/chaplin/redirects'

class Chaplin
  describe Redirects do

    let(:raw_redirect_data) do
      {
        "create_article" => [
          "/",
          [
            ["POST classes/article",
             {
              "content" => "{{ content }}",
              "title" => "{{ title }}"
            }
          ]
          ]
        ]
      }
    end

    describe ".load" do
      let(:redirects) { Redirects.load(raw_redirect_data) }

      let(:create_article) { redirects['create_article'] }

      it "loads redirects path from raw data" do
        expect(create_article.redirect_path).to eq '/'
      end

      it "loads redirects api requests from raw data" do
        expect(create_article.api_requests.first.http_method).to eq :post
      end

    end
  end
end
