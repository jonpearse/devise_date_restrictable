require 'test_helper'

class ValidationTests < ActiveSupport::TestCase

  # Make sure we can set things independently
  test 'ensure we can set valid_from without valid_until' do

    assert( User.new( valid_from: Date.today ).valid? )

  end

  test 'ensure we can set valid_until without valid_from' do

    assert( User.new( valid_until: Date.today ).valid? )

  end

  # Now check the both
  test 'ensure we can set valid_until and valid_from, as long as they’re chronologically sensible' do

    assert( User.new( valid_from: ( Date.today - 1.day ), valid_until: Date.today ).valid? )

  end

  test 'ensure we can set valid_until and valid_from for the same day' do

    assert( User.new( valid_from: Date.today, valid_until: Date.today ).valid? )

  end

  test 'ensure we cannot set valid_until to a point before valid_until' do

    assert_not( User.new( valid_from: Date.today, valid_until: ( Date.today - 1.day )).valid? )

  end
end
