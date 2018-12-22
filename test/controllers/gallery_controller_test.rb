require 'test_helper'

class GalleryControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get gallery_index_url
    assert_response :success
  end

  test 'should get show' do
    get gallery_show_url, params: { id: 1 }
    assert_response :success
  end
end
