#!/usr/bin/env ruby
# encoding: utf-8
# Author: Roy L Zuo (roylzuo at gmail dot com)
#

describe BaiduYunConn, :vcr do
  before :all do
    @conn = BaiduYunConn.new
  end

  it 'should correctly send command to server' do
    res = @conn.run :quota_info
    expect(res).to be_a(Hash)
    expect(res).to have_key( :quota )
  end
end

describe BaiduYun, :vcr do
  before :all do
    @c = BaiduYun.new
  end

  before :each do
    @c.cd
    @c.mkdir 'test'
    @c.cd 'test'
  end

  let(:root) { @c.pwd.first }

  context '#meta' do
    it 'should return a hash with md5 and etc' do
      res = @c.meta('.')
      expect(res).to have_key( :list )
      expect(res[:list].first).to have_key( :path )
    end

    it 'should return info of pwd if no arg is supplied' do
      expect(@c.meta).to have_key( :list )
    end
  end

  context '#pwd' do
    it 'should return current directory remotely' do
      expect(@c.pwd.first).to match(%r{/apps/\w+/test})
      expect(@c.meta[:list].first[:path]).to match(%r{/apps/\w+/test})
    end
  end

  context '#cd' do
    it 'should change directory' do
      res = @c.meta[:list].first[:path]
      expect(@c.pwd.first).to match(%r{/apps/\w+/test})
      @c.mkdir 'tttt'
      @c.cd 'tttt'
      res1 = @c.meta[:list].first[:path]
      expect( res ).to_not eq(res1)
      @c.rm 'tttt'
    end

    it 'should change to home without any arg' do
      @c.cd
      res = @c.meta[:list].first[:path]
      expect(res).to match(%r{^/apps/\w+$})
    end
  end

  context '#ls' do
    it 'should return files of pwd if nothing is supplied' do
      expect(@c.ls).to have_key(:list)
    end

    it 'should be able to list subdirs when supplied as argument' do
      @c.cd
      expect(@c.ls("test")).to have_key(:list)
    end
  end

  context '#cp' do
    it 'should be able to copy dir or file' do
      @c.cd
      res = @c.cp 'test', 'test1'
      expect(res).to_not have_key(:error_code)
    end
  end

  context "#quota" do
    it 'should be able to return quota info' do
      expect(@c.quota).to have_key(:quota)
    end
  end

  context '#rm' do
    it 'should be able to remove directory or file' do
      @c.mkdir 'test2'
      @c.rm 'test2'
      res = @c.ls
      expect(res[:list].map{|h| h[:path] }).to_not include("#{root}/test2")
    end
  end

  context '#mkdir' do
    it 'should be able to create a dir' do
      @c.mkdir 'test5'
      res = @c.ls
      expect(res[:list].map{|h| h[:path] }).to include("#{root}/test5")
    end
  end

  context '#put' do
    it 'should be able to upload a file' do
      res = @c.put fixture('test_file')
      expect(res).to_not have_key(:error_code)
      expect(res).to have_key(:fs_id)
    end
  end

  context '#url' do
    it 'should return a full url for a file' do
      @c.put fixture('test_file')
      expect(@c.url 'test_file').to be_a(String)
      expect(@c.url 'test_file').to start_with('http')
    end
  end

  context '#find' do
    it 'should be able to find files' do
      @c.mkdir 'test4'
      @c.cd 'test4'
      @c.put fixture('test_file')
      res = @c.find 'test_file'
      expect(res[:list].map{|h| h[:path] }).to include("#{root}/test_file")
    end
  end

  context '#mv' do
    it 'should be able to move file' do
      @c.mkdir 'test6'
      @c.mkdir 'test7'
      @c.cd 'test6'
      @c.put fixture('test_file')
      @c.cd '..'
      @c.mv 'test6/test_file', 'test7/haha'
      res = @c.find('haha')
      expect(res[:list].map{|h| h[:path]}).to include("#{root}/test7/haha")
    end
  end
end
