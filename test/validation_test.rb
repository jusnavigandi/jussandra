require 'test_helper'

class ValidationTest < JussandraTestCase
  
  test "save! raises an error" do
    begin
      customer = Customer.new :first_name=>"steve", :date_of_birth=>Date.parse("1979/12/25")
      customer.save!
      flunk "Should have failed to save"
    rescue Jussandra::Validation::RecordInvalidError => e
      assert_equal customer, e.record
    end
  end

  test "create! raises an error" do
    begin
      customer = Customer.create! :first_name=>"steve", :date_of_birth=>Date.parse("1979/12/25")
      flunk "Should have failed to create!"
    rescue Jussandra::Validation::RecordInvalidError => e
      assert_kind_of Customer, e.record
    end
  end


end