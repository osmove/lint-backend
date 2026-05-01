module LintFormHelper
  def lint_form_for(record, options = {}, &)
    form_for(record, normalize_lint_form_options(options), &)
  end

  def lint_form_with(**options, &)
    form_with(**normalize_lint_form_options(options), &)
  end

private

  def normalize_lint_form_options(options)
    options = options.dup
    options.delete(:layout)
    options.delete(:label_col)
    options.delete(:control_col)
    options[:builder] ||= LintFormBuilder
    options
  end
end
