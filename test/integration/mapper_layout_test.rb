require 'test_helper'

class MapperLayoutTest < ActionDispatch::IntegrationTest
  test "mapper links" do
    get root_path
    assert_template 'mapper/show'
    assert_select "a[href=?]", root_path, count: 1
  end
end
