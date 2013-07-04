namespace :bootstrap do
  desc "bootstraping app"
  task :run => [
    "db:create:all",
    "db:migrate",
    "db:seed"
  ]
end
