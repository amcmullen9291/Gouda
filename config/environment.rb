require 'bundler'
Bundler.require

set :database, {:adapter => "sqlite3", :database => "GouDA.db"}

require_all 'mvc'
