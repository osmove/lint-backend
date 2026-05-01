require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test 'project groups repositories under a user' do
    project = projects(:one)
    repository = repositories(:one)

    repository.update!(project: project)

    assert_equal users(:one), project.user
    assert_includes project.repositories, repository
  end

  test 'project generates a slug from its name' do
    project = users(:one).projects.create!(name: 'Twoody Mobile')

    assert_equal 'twoody-mobile', project.slug
  end
end
