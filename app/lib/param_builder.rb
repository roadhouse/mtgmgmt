class ParamBuilder
  def initialize(string)
    @string_filter = string
  end

  def self.params(string)
    new(string).param_builder
  end

  def fixed_params
    @string_filter.gsub(": ", ":").split(" ")
  end

  def params_pair(params)
    params.split(/:\s*/)
  end

  def filter_params
    fixed_params.each_with_object({}) do |filter, query|
      params = filter.split(/:\s*/)

      if params_pair(filter).size > 1
        query[params.first.downcase.to_sym] = params.last.downcase.capitalize
      else
        query[:name] = query[:name].to_a << params.last
      end
    end
  end

  def param_builder
    filter_params.tap do |query|
      query[:name] = query[:name].join(" ") if filter_params[:name]
    end
  end
end
