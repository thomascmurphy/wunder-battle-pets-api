# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
disciplines = Discipline.create([{ name: Discipline::TURN_BASED_TYPE, description: "Attackers alternate, dealing damage until one pet is out of integrity. Speed followed by intelligence and strength decide the first attacker, speed and strength determine the damage of the attack, then speed and intelligence of the defender reveals how much of that attack passes through the defenses to deal damage." },
                                 { name: Discipline::PURE_STATS_TYPE, description: "Both pets simply flex their muscles at one another and compare stats to determine a winner (each stat is compared individually and whichever pet has the most winning categories is declared the winner" }])
