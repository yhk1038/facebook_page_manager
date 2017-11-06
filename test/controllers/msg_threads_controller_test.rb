require 'test_helper'

class MsgThreadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @msg_thread = msg_threads(:one)
  end

  test "should get index" do
    get msg_threads_url
    assert_response :success
  end

  test "should get new" do
    get new_msg_thread_url
    assert_response :success
  end

  test "should create msg_thread" do
    assert_difference('MsgThread.count') do
      post msg_threads_url, params: { msg_thread: { link: @msg_thread.link, msg_count: @msg_thread.msg_count, other_info: @msg_thread.other_info, page_id: @msg_thread.page_id, sender_name: @msg_thread.sender_name, sender_uid: @msg_thread.sender_uid, uid: @msg_thread.uid, unread_count: @msg_thread.unread_count, updated_time: @msg_thread.updated_time } }
    end

    assert_redirected_to msg_thread_url(MsgThread.last)
  end

  test "should show msg_thread" do
    get msg_thread_url(@msg_thread)
    assert_response :success
  end

  test "should get edit" do
    get edit_msg_thread_url(@msg_thread)
    assert_response :success
  end

  test "should update msg_thread" do
    patch msg_thread_url(@msg_thread), params: { msg_thread: { link: @msg_thread.link, msg_count: @msg_thread.msg_count, other_info: @msg_thread.other_info, page_id: @msg_thread.page_id, sender_name: @msg_thread.sender_name, sender_uid: @msg_thread.sender_uid, uid: @msg_thread.uid, unread_count: @msg_thread.unread_count, updated_time: @msg_thread.updated_time } }
    assert_redirected_to msg_thread_url(@msg_thread)
  end

  test "should destroy msg_thread" do
    assert_difference('MsgThread.count', -1) do
      delete msg_thread_url(@msg_thread)
    end

    assert_redirected_to msg_threads_url
  end
end
