#!/usr/bin/env ruby
# encoding: utf-8
# Description:
#

describe NetHTTPConnection, :vcr => true do
  let(:conn) { BaiduYunConn.new }

  it 'should load the right connection module' do
    expect(BaiduYunConn.ancestors).to include NetHTTPConnection
  end

  it 'should correctly send requests' do
    resp = conn.request 'http://baidu.com'
    expect(resp.code).to eq '200'
  end

  it 'should allow login' do
    # no idea how to test it hear..... do it manually
  end
end
