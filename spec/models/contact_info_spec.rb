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

require 'spec_helper'

describe ContactInfo do
  pending "add some examples to (or delete) #{__FILE__}"
end
