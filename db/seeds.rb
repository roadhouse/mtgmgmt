User.create!(login: roadhouse)

Rake::Task['import:cards'].invoke


Card.create(name: "Dissipate", set: "nenhum", card_type: "Instant")
Card.create(name: "Druids' Repository", set:"Avacyn Restored", card_type: "Enchantment")
Card.create(name: "Scavenging Ghoul", set: "nenhum", card_type: "nenhum")
Card.create(name: "Mark Of Mutiny", set: "nenhum", card_type: "nenhum")
Card.create(name: "Arbor Elf", set: "nenhum", card_type: "nenhum")
Card.create(name: "Witch Hunter", set: "nenhum", card_type: "nenhum")
