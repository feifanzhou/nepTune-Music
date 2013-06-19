# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  fname             :string(255)
#  lname             :string(255)
#  email             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  willingToBetaTest :boolean          default(FALSE)
#  isBetaTester      :boolean          default(FALSE)
#  isArtist          :boolean          default(FALSE)
#  password_digest   :string(255)
#  has_temp_password :boolean
#  remember_token    :string(255)
#  username          :string(255)
#

require 'spec_helper'

describe Artist do
  pending "add some examples to (or delete) #{__FILE__}"
end
