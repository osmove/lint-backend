require 'test_helper'

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repository = repositories(:one)
    @user = @repository.user
  end

  test "should get index" do
    get user_repository_documents_url(@user, @repository)
    assert_response :success
  end

  test "should show document with stubbed git backend" do
    fake_ssh = Object.new
    fake_ssh.define_singleton_method(:exec!) { |_command| "# README\n\nHello from Lint" }

    original_start = Net::SSH.method(:start)
    Net::SSH.singleton_class.send(:define_method, :start) do |*_args, &block|
      block.call(fake_ssh)
    end

    begin
      get user_repository_document_url(@user, @repository, "README.md")
    ensure
      Net::SSH.singleton_class.send(:define_method, :start, original_start)
    end

    assert_response :success
  end
end
