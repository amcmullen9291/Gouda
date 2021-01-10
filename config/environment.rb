require 'bundler'
Bundler.require

set :database, {:adapter => "sqlite3", :database => "Goouda.db"}

require_all 'mvc'
