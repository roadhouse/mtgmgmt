require "spec_helper_active_record"
require "./app/models/card"

describe Card do
  it { should validate_presence_of :name }
  it { should validate_presence_of :set }
  it { should validate_presence_of :card_type }
end
