User.create!(login: roadhouse)

Rake::Task['import:cards'].invoke


Card.create(name: "Dissipate", set: "nenhum", card_type: "Instant")
Card.create(name: "Druids' Repository", set:"Avacyn Restored", card_type: "Enchantment")
Card.create(name: "Scavenging Ghoul", set: "nenhum", card_type: "nenhum")
