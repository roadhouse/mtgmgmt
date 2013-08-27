User.create!(login: roadhouse)

Rake::Task['import:cards'].invoke
