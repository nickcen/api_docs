class App < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :specs
end
