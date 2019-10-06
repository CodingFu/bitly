RSpec.describe Bitly::HTTP::Request do
  let(:uri) { URI.parse("http://example.com") }

  it "is initialized with a URI and the method is GET by default" do
    request = Bitly::HTTP::Request.new(uri: uri)
    expect(request.uri).to eq(uri)
    expect(request.method).to eq("GET")
  end

  it "is initialized with a URI and a method" do
    request = Bitly::HTTP::Request.new(uri: uri, method: "POST")
    expect(request.uri).to eq(uri)
    expect(request.method).to eq("POST")
  end

  it "is initialized with a URI and a method and an optional params hash" do
    request = Bitly::HTTP::Request.new(uri: uri, method: "GET", params: { "foo" => "bar" })
    expect(request.params).to eq({ "foo" => "bar" })
  end

  it "is initialized with a URI and a method and an optional headers hash" do
    request = Bitly::HTTP::Request.new(uri: uri, method: "GET", headers: { "foo" => "bar" })
    expect(request.headers).to eq({ "foo" => "bar" })
  end

  it "expects the uri to be an object of type URI" do
    expect {
      Bitly::HTTP::Request.new(uri: "http://example.com", method: "GET")
    }.to raise_error(ArgumentError)
  end

  it "expects the method to be an HTTP method" do
    expect {
      Bitly::HTTP::Request.new(uri: uri, method: "SLEEP")
    }.to raise_error(ArgumentError)
  end

  it "expects the params to be a hash" do
    expect {
      Bitly::HTTP::Request.new(uri: uri, method: "GET", params: "wrong")
    }.to raise_error(ArgumentError)
  end

  it "expects the headers to be a hash" do
    expect {
      Bitly::HTTP::Request.new(uri: uri, method: "GET", headers: "wrong")
    }.to raise_error(ArgumentError)
  end

  describe "when the method is GET" do
    it "adds the params to the URL query string" do
      request = Bitly::HTTP::Request.new(uri: uri, method: "GET", params: { "foo" => "bar" })
      expect(request.uri.to_s).to eq("http://example.com?foo=bar")
    end

    it "adds the params to the existing URL query string" do
      uri.query = "foo=baz"
      request = Bitly::HTTP::Request.new(uri: uri, method: "GET", params: { "foo" => "bar" })
      expect(request.uri.to_s).to eq("http://example.com?foo=baz&foo=bar")
    end
  end

end