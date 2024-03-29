require 'rails_helper'

load File.expand_path('../helpers.rb', __FILE__)

RSpec.configure do |config|
  config.before(:all) do
    FakeWeb.allow_net_connect = false
  end
  config.include HTMLSpecHelper
end

# Well, copied from onebox spec
shared_context "engines" do
  before(:each) do
    fake(@uri || @link, response(described_class.onebox_name))
    @onebox = described_class.new(@link)
    @html = @onebox.to_html
    @data = Onebox::Helpers.symbolize_keys(@onebox.send(:data))
  end
  before(:each) { Onebox.options.cache.clear }

  let(:onebox) { @onebox }
  let(:html) { @html }
  let(:data) { @data }
  let(:link) { @link }

  def escaped_data(key)
    CGI.escapeHTML(data[key])
  end
end

shared_examples_for "an engine" do
  it "responds to data" do
    expect(described_class.private_instance_methods).to include(:data)
  end

  it "responds to record" do
    expect(described_class.private_instance_methods).to include(:record)
  end

  it "correctly matches the url" do
    onebox = Onebox::Matcher.new(link).oneboxed
    expect(onebox).to be(described_class)
  end

  describe "#data" do
    it "includes title" do
      expect(data[:title]).not_to be_nil
    end

    it "includes link" do
      expect(data[:link]).not_to be_nil
    end
  end
end

shared_examples_for "a layout engine" do
  describe "#to_html" do
    it "includes subname" do
      expect(html).to include(%|<aside class="onebox #{described_class.onebox_name}">|)
    end

    it "includes title" do
      expect(html).to include(escaped_data(:title))
    end

    it "includes link" do
      expect(html).to include(%|class="link" href="#{data[:link]}|)
    end

    it "includes badge" do
      expect(html).to include(%|<strong class="name">#{data[:badge]}</strong>|)
    end

    it "includes domain" do
      expect(html).to include(%|class="domain" href="#{escaped_data(:domain)}|)
    end
  end
end
