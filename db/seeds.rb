# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create({
  first_name: "example",
  email: "example@example.com",
  password: "password"
})

routine = Routine.create({
  user_id: user.id,
  name: "Tabata",
  description: "The hardest interval you've ever done!",
  link: "https://en.wikipedia.org/wiki/High-intensity_interval_training#Tabata_regimen",
  times: 1
})

warm_up_group = Group.create({
  routine_id: routine.id,
})

tabata_group = Group.create({
  routine_id: routine.id,
  order: 2,
  times: 8
})

cool_down_group = Group.create({
  routine_id: routine.id,
  order: 3
})

warm_up = Interval.create({
  group_id: warm_up_group.id,
  name: "Warm Up",
  duration: 600
})

tabata = Interval.create({
  group_id: tabata_group.id,
  name: "Sprint",
  duration: 20
})

tabata = Interval.create({
  group_id: tabata_group.id,
  name: "Rest",
  order: 2,
  duration: 10
})

warm_up = Interval.create({
  group_id: cool_down_group.id,
  name: "Cool Down",
  duration: 600
})

