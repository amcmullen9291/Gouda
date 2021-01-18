require 'bundler'
Bundler.require

set :database, {:adapter => "sqlite3", :database => "GoudaTime.db"}

require_all 'mvc'
