user = User.create(
  first_name: "example",
  email: "example2@example.com",
  password: "password"
)

5.times do |i|
  routine = Routine.create(
    user_id: user.id,
    name: "Tabata #{i}",
    description: "The hardest interval you've ever done!",
    link: "https://en.wikipedia.org/wiki/" \
      "High-intensity_interval_training#Tabata_regimen",
    times: 1,
    public: true
  )

  warm_up_group = Group.create(
    routine_id: routine.id
  )

  tabata_group = Group.create(
    routine_id: routine.id,
    order: 2,
    times: 8
  )

  cool_down_group = Group.create(
    routine_id: routine.id,
    order: 3
  )

  Interval.create(
    group_id: warm_up_group.id,
    name: "Warm Up",
    duration: 600
  )

  Interval.create(
    group_id: tabata_group.id,
    name: "Sprint",
    duration: 20
  )

  Interval.create(
    group_id: tabata_group.id,
    name: "Rest",
    order: 2,
    duration: 10
  )

  Interval.create(
    group_id: cool_down_group.id,
    name: "Cool Down",
    duration: 600
  )
end
