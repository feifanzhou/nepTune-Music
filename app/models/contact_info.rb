# == Schema Information
#
# Table name: contact_infos
#
#  id               :integer          not null, primary key
#  phone            :string(255)
#  email            :string(255)
#  website          :string(255)
#  contactable_id   :integer
#  contactable_type :string(64)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class ContactInfo < ActiveRecord::Base
	# ContactInfo will also be responsible for
	# formatting data across different locales,
	# which will be important as we scale worldwide
  attr_accessible :email, :phone, :website

  belongs_to :contactable, polymorphic: true
end
