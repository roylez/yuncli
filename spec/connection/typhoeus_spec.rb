#!/usr/bin/env ruby
# encoding: utf-8
# Description:
#

describe TyphoeusConnection, :vcr do
  let(:conn) { BaiduYunConn.new }

  it 'should load the right connection module' do
    expect(BaiduYunConn.ancestors).to include TyphoeusConnection
  end

  it 'should correctly send requests' do
    resp = conn.request 'http://baidu.com'
    expect(resp.code).to eq 200
  end

end
