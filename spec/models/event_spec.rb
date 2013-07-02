# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  start_at   :datetime
#  end_at     :datetime
#  creator_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Event do

  before { @event = Event.new(name: "Sweet stuff",
                              start_at: DateTime.now(),
                              end_at: DateTime.now().since(3600) )
  }

  it { should be_valid }

end
