require 'bundler'
Bundler.require

set :database, {:adapter => "sqlite3", :database => "GoudaClock.db"}

require_all 'mvc'
