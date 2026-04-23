module ApplicationHelper
  # Some legacy admin forms still render Cocoon-style helper calls even though
  # the dedicated gem is no longer part of the backend bundle. These fallbacks
  # keep the server-rendered forms stable and preserve the expected markup.
  def link_to_add_association(name = nil, form = nil, association = nil, *args, &block)
    html_options = args.extract_options!.dup
    html_options.delete(:render_options)
    html_options.delete(:partial)
    label = block_given? ? capture(&block) : name
    classes = [html_options[:class], "add_fields"].compact.join(" ")

    link_to(
      label,
      html_options.delete(:href) || "#",
      html_options.merge(
        class: classes,
        "data-association": association,
        "data-association-type": "add"
      )
    )
  end

  def link_to_remove_association(name = nil, form = nil, *args, &block)
    html_options = args.extract_options!.dup
    label = block_given? ? capture(&block) : name
    classes = [html_options[:class], "remove_fields"].compact.join(" ")
    destroy_field = form&.hidden_field(:_destroy, value: 0)

    safe_join(
      [
        destroy_field,
        link_to(
          label,
          html_options.delete(:href) || "#",
          html_options.merge(class: classes, "data-association-type": "remove")
        )
      ].compact
    )
  end
end
