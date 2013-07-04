def minimal_form_for(object, *args, &block)
  options = args.extract_options!
  simple_form_for(object, *(args << options.merge(:builder => MinimalFormBuilder)), &block)
end

class MinimalFormBuilder < SimpleForm::FormBuilder
  def input(attribute_name, options = {}, &block)
    options[:placeholder] = attribute_name.to_s.titleize if options[:placeholder].blank?
    options[:label] = false

    super
  end
end
