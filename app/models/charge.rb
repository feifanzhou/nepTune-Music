# == Schema Information
#
# Table name: charges
#
#  id         :integer          not null, primary key
#  amount     :integer
#  token      :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Charge < ActiveRecord::Base
  attr_accessible :amount, :token, :user_id
end
