require 'spec_helper'

describe Book do

  subject { FactoryGirl.build(:book) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :isbn }

end
