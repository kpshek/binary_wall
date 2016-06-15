#!/usr/bin/env ruby
require 'sinatra'
require 'sinatra/reloader' if development?
require 'haml'

configure do
  set :haml, format: :html5
  set :haml, escape_html: true
end

get '/' do
  haml :index
end

get '/wall' do
  text = params[:text]

  binary_quote = text.unpack('C*').map { |e| "%08d" % e.to_s(2) }
  binary_quote = binary_quote.map { |s| s.split(//) }

  @binary_wall = "#{text}\n"

  binary_quote.transpose.each do |row|
    row.each do |c|
      @binary_wall << c
    end
    @binary_wall << "\n"
  end

  haml :wall
end
