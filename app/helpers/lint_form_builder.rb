# rubocop:disable Metrics/ParameterLists, Style/SuperArguments
class LintFormBuilder < ActionView::Helpers::FormBuilder
  LEGACY_FIELD_OPTIONS = %i[
    help
    hide_label
    input_group_class
    inline
    label
    label_class
    label_col
    layout
    prepend
    append
    skip_label
    wrapper
  ].freeze

  FIELD_METHODS = %i[
    color_field
    date_field
    datetime_field
    datetime_local_field
    email_field
    file_field
    month_field
    number_field
    password_field
    phone_field
    search_field
    telephone_field
    text_area
    text_field
    time_field
    url_field
    week_field
  ].freeze

  FIELD_METHODS.each do |method_name|
    define_method(method_name) do |method, options = {}|
      field_with_wrapper(method, options) do |field_options|
        super(method, add_field_class(field_options, default_field_class))
      end
    end
  end

  def label(method, text = nil, options = {}, &)
    if text.is_a?(Hash)
      options = text.merge(options)
      text = options.delete(:value) || options.delete(:text)
    end

    super(method, text, options, &)
  end

  def select(method, choices = nil, options = {}, html_options = {}, &)
    field_with_wrapper(method, options, html_options) do |field_options, field_html_options|
      super(method, choices, field_options, add_field_class(field_html_options, 'form-select'), &)
    end
  end

  def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
    field_with_wrapper(method, options, html_options) do |field_options, field_html_options|
      super(method, collection, value_method, text_method, field_options, add_field_class(field_html_options, 'form-select'))
    end
  end

  def datetime_select(method, options = {}, html_options = {})
    field_with_wrapper(method, options, html_options) do |field_options, field_html_options|
      super(method, field_options, add_field_class(field_html_options, 'form-select'))
    end
  end

  def check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
    choice_field_with_label(method, options) do |field_options|
      super(method, add_field_class(field_options, 'form-check-input'), checked_value, unchecked_value)
    end
  end

  def radio_button(method, tag_value, options = {})
    choice_field_with_label(method, options) do |field_options|
      super(method, tag_value, add_field_class(field_options, 'form-check-input'))
    end
  end

  def collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {}, &)
    field_with_wrapper(method, options, html_options) do |field_options, field_html_options|
      super(method, collection, value_method, text_method, field_options, field_html_options, &)
    end
  end

  def collection_radio_buttons(method, collection, value_method, text_method, options = {}, html_options = {}, &)
    field_with_wrapper(method, options, html_options) do |field_options, field_html_options|
      super(method, collection, value_method, text_method, field_options, field_html_options, &)
    end
  end

  def form_group(method = nil, options = {}, &)
    label_options = options.delete(:label)
    label_text = label_options.is_a?(Hash) ? label_options[:text] : label_options
    help = options.delete(:help)
    classes = ['form-group', options.delete(:class)].compact.join(' ')

    @template.content_tag(:div, class: classes) do
      @template.safe_join(
        [
          method && label_text != false ? label(method, label_text) : nil,
          @template.capture(&),
          help_text(help)
        ].compact
      )
    end
  end

  def hidden_field(method, options = {})
    super(method, strip_legacy_options(options))
  end

  def fields_for(record_name, record_object = nil, fields_options = nil, &)
    fields_options ||= {}
    fields_options[:builder] ||= self.class
    super(record_name, record_object, fields_options, &)
  end

  def primary(value = nil, options = {})
    submit(value, options.merge(class: merge_classes(options[:class], 'btn btn-primary')))
  end

  def submit(value = nil, options = {})
    super(value, options.merge(class: merge_classes(options[:class], 'btn btn-primary')))
  end

private

  def field_with_wrapper(method, options = {}, html_options = {})
    original_options = options.to_h.symbolize_keys
    original_html_options = html_options.to_h.symbolize_keys
    field_options = strip_legacy_options(original_options)
    field_html_options = strip_legacy_options(original_html_options)
    field_html_options = add_field_class(field_html_options, default_field_class)
    field_markup = yield(field_options, field_html_options)

    wrapper_options = wrapper_options_for(original_options, original_html_options)
    return field_markup if wrapper_options == false

    @template.content_tag(:div, class: wrapper_classes(wrapper_options)) do
      @template.safe_join(
        [
          label_for(method, original_options),
          field_markup,
          help_text(original_options[:help]),
          error_text(method)
        ].compact
      )
    end
  end

  def choice_field_with_label(method, options = {})
    original_options = options.to_h.symbolize_keys
    field_options = strip_legacy_options(original_options)
    label_text = original_options[:label]
    field_markup = yield(field_options)

    if label_text == false || original_options[:hide_label]
      field_markup
    else
      @template.content_tag(:div, class: 'form-check') do
        label(method, nil, class: 'form-check-label') do
          @template.safe_join([field_markup, ' ', label_text || method.to_s.humanize])
        end
      end
    end
  end

  def label_for(method, options)
    return if options[:hide_label] || options[:label] == false

    label_text = options[:label].is_a?(Hash) ? options[:label][:text] : options[:label]
    label(method, label_text, class: 'form-label')
  end

  def default_field_class
    'form-control'
  end

  def add_field_class(options, class_name)
    options.merge(class: merge_classes(options[:class], class_name))
  end

  def strip_legacy_options(options)
    options.except(*LEGACY_FIELD_OPTIONS)
  end

  def wrapper_options_for(options, html_options)
    options[:wrapper] || html_options[:wrapper]
  end

  def wrapper_classes(wrapper_options)
    return 'form-group' if wrapper_options.blank?

    ['form-group', wrapper_options[:class]].compact.join(' ')
  end

  def help_text(help)
    return if help.blank?

    @template.content_tag(:div, help, class: 'form-text')
  end

  def error_text(method)
    return if object.blank? || object.errors[method].blank?

    @template.content_tag(:div, object.errors[method].to_sentence, class: 'invalid-feedback')
  end

  def merge_classes(*classes)
    classes
      .flatten
      .compact
      .flat_map { |class_name| class_name.to_s.split }
      .uniq
      .join(' ')
  end
end
# rubocop:enable Metrics/ParameterLists, Style/SuperArguments
