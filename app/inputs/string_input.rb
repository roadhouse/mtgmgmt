class StringInput < SimpleForm::Inputs::StringInput
  def input
    @options[:placeholder] = attribute_name.to_s.titleize if options[:placeholder].blank?
    @options[:label] = false
    super
  end
end
