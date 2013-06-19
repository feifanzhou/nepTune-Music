# == Schema Information
#
# Table name: attendees
#
#  id         :integer          not null, primary key
#  status     :string(16)
#  user_id    :integer
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Attendee do
  pending "add some examples to (or delete) #{__FILE__}"
end
