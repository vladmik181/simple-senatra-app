# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

DB = SQLite3::Database.open 'data.db'
DB.execute 'CREATE TABLE IF NOT EXISTS objects(key STRING UNIQUE, value STRING)'

get '/get/:key' do
  query = DB.query 'SELECT key, value FROM objects WHERE key=?', params['key']
  response = query.next
  return response.to_json
end

get '/set/:key&:value' do
  DB.execute 'INSERT INTO objects (key, value) VALUES (?, ?)', params['key'], params['value']
  return 'Status 204'
end

