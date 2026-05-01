require 'test_helper'

class LintFormHelperTest < ActionView::TestCase
  tests ApplicationHelper

  test 'lint_form_for renders Tailwind-compatible field wrappers' do
    user = users(:one)

    html = lint_form_for(user, url: '/users') do |form|
      safe_join(
        [
          form.text_field(:username, hide_label: true, wrapper: { class: 'compact' }),
          form.radio_button(:role, 'admin', label: 'Admin'),
          form.primary('Save')
        ]
      )
    end

    assert_includes html, 'class="form-group compact"'
    assert_includes html, 'class="form-control"'
    assert_includes html, 'class="form-check"'
    assert_includes html, 'Admin'
    assert_includes html, 'class="btn btn-primary"'
    assert_no_match(/hide_label|wrapper=/, html)
  end

  test 'lint_form_with normalizes legacy layout options' do
    user = users(:one)

    html = lint_form_with(model: user, url: '/users', layout: :horizontal, label_col: 'col-sm-2') do |form|
      form.email_field(:email, label: { text: 'Email address' })
    end

    assert_includes html, 'Email address'
    assert_includes html, 'class="form-label"'
    assert_includes html, 'class="form-control"'
    assert_no_match(/layout=|label_col/, html)
  end
end
