class Charge < ActiveRecord::Base
  attr_accessible :amount, :token, :user_id
end
