require 'test_helper'

class IssuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @issue = issues(:one)
    @repository = @issue.repository
    @user = @repository.user
  end

  test "should get index" do
    get user_repository_issues_url(@user, @repository)
    assert_response :success
  end

  test "should get new" do
    get new_user_repository_issue_url(@user, @repository)
    assert_response :success
  end

  test "should create issue" do
    assert_difference("Issue.count", 1) do
      post user_repository_issues_url(@user, @repository), params: {
        issue: {
          title: "New Issue",
          slug: "new-issue",
          origin: "manual",
          body: "Issue body",
          language_id: @issue.language_id,
          framework_id: @issue.framework_id
        }
      }
    end

    assert_redirected_to user_repository_issue_url(@user, @repository, Issue.last)
  end

  test "should show issue" do
    get user_repository_issue_url(@user, @repository, @issue)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_repository_issue_url(@user, @repository, @issue)
    assert_response :success
  end

  test "should update issue" do
    patch user_repository_issue_url(@user, @repository, @issue), params: {
      issue: {
        title: "Updated Issue",
        slug: @issue.slug,
        origin: @issue.origin,
        body: "Updated body",
        language_id: @issue.language_id,
        framework_id: @issue.framework_id
      }
    }

    assert_redirected_to user_repository_issue_url(@user, @repository, @issue)
    assert_equal "Updated Issue", @issue.reload.title
  end

  test "should destroy issue" do
    issue = Issue.create!(
      title: "Disposable Issue",
      slug: "disposable-issue",
      origin: "manual",
      repository: @repository,
      user: @user
    )

    assert_difference("Issue.count", -1) do
      delete user_repository_issue_url(@user, @repository, issue)
    end

    assert_redirected_to user_repository_issues_url(@user, @repository)
  end
end
