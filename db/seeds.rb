User.create!(login: roadhouse)

Rake::Task['import:cards'].invoke


Card.create(name: "Commune with Nature", set: "nenhum", card_type: "nenhum")
Card.create(name: "Spellkite", set: "nenhum", card_type: "nenhum")
