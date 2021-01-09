require 'bundler'
Bundler.require

set :database, {:adapter => "sqlite3", :database => "Gouda.db"}

require_all 'mvc'
