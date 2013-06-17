class Event < ActiveRecord::Base
  attr_accessible :creator_id, :end_at, :name, :start_at
end
