SimpleForm.setup do |config|
  config.wrappers :small, tag: false do |b|
    b.use :html5
    b.use :placeholder

    b.use :input 
  end
end
