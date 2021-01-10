require 'bundler'
Bundler.require

set :database, {:adapter => "sqlite3", :database => "Guoda.db"}

require_all 'mvc'
