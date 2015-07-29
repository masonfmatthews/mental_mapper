User.create!(name: "Mason",
             email: "mason@example.com",
             password: "password",
             password_confirmation: "password")

unit_hash = {"Week 1: Day 1" => ["Procedural Programming", "Control Flow", "Variables"],
  "Week 1: Day 2" => ["Methods", "Arrays", "Git", "init, add, commit, push", "Commit Messages"],
  "Week 1: Day 3" => ["Arrays", "Hashes"],
  "Week 1: Day 4" => ["Object Oriented Programming", "Classes"],
  "Week 2: Day 1" => ["Ruby", "Exceptions", "Testing", "Inheritance", "fork, clone, pull", ".git, .gitignore"],
  "Week 2: Day 2" => ["Modules", "Composition"],
  "Week 2: Day 3" => ["Regular Expressions", "Blocks", "Enumerable"],
  "Week 2: Day 4" => ["Gems", "TDD"],
  "Week 3: Day 1" => ["Databases", "DB Design", "Migrations", "ActiveRecord"],
  "Week 3: Day 2" => ["SQL", "Many-to-many"],
  "Week 3: Day 3" => ["Models", "Unit Testing"],
  "Week 3: Day 4" => ["Associations", "Validations", "branch, merge"],
  "Week 4: Day 1" => ["APIs", "Consuming APIs", "Web Technologies", "HTTP", "JSON"],
  "Week 4: Day 2" => ["Producing APIs", "HTTP Verbs", "Rails", "MVC"],
  "Week 4: Day 3" => ["Controllers", "Routing", "Controller Testing", "HTTP Verbs"],
  "Week 4: Day 4" => ["Seeds", "Fixtures"],
  "Week 5: Day 1" => ["HTML", "CSS"],
  "Week 5: Day 2" => ["Views", "ERB", "HTML Forms"],
  "Week 5: Day 3" => ["REST", "Scaffold"],
  "Week 5: Day 4" => ["Helpers", "Partials", "Deployment", "Workflows"],
  "Week 6: Day 1" => ["Asset Pipeline", "SCSS"],
  "Week 6: Day 2" => ["Session", "Web App Patterns", "Authentication"],
  "Week 6: Day 3" => ["Integration Testing", "Authorization"],
  "Week 6: Day 4" => ["Nested Attributes"],
  "Week 7: Day 1" => ["JavaScript", "DOM Manipulataion"],
  "Week 7: Day 2" => ["jQuery", "Unobtrusive JavaScript"],
  "Week 7: Day 3" => ["AJAX"],
  "Week 7: Day 4" => [],
  "Week 8: Day 1" => ["Indices", "Efficiency", "Query Optimizations", "Runtime Optimizations", "Memory Optimizations"],
  "Week 8: Day 2" => ["Background Processing"],
  "Week 8: Day 3" => ["Mailers"],
  "Week 8: Day 4" => ["File Uploads"],
  "Week 9: Day 1" => ["oAuth", "DevOps"],
  "Week 9: Day 2" => ["d3.js"],
  "Week 9: Day 3" => [],
  "Week 9: Day 4" => []
}

first_day = "2015-08-31".to_date
first_week = (0..3).to_a.map {|i| first_day + i.days}
all_days = (0..8).to_a.map {|j| first_week.map {|day| day + j.weeks}}
all_days.flatten!

unit_hash.each do |k, v|
  u = Unit.create!(name: k,
             delivered_at: all_days.shift)
  v.each do |concept_name|
    u.coverages.build(concept_uuid: Concept.where(name: concept_name).first.uuid)
  end
  u.save!
end

assignment_hashes = [
  { name: "User Input Statistics",
    uri: "https://github.com/tiyd-rails-2015-08/input_statistics",
    concepts: ["Control Flow", "Variables"]},
  { name: "Number Guessing Game",
    uri: "https://github.com/tiyd-rails-2015-08/number_guessing",
    concepts: ["Methods", "Arrays", "add, commit, push"]},
  { name: "Blackjack Advisor",
    uri: "https://github.com/tiyd-rails-2015-08/blackjack_advisor",
    concepts: ["Methods", "Arrays", "Hashes"]},
  { name: "Currency Converter",
    uri: "https://github.com/tiyd-rails-2015-08/currency_converter_project",
    concepts: ["Methods", "Arrays", "Hashes", "Exceptions"]},
  { name: "Battleship Day 1",
    uri: "https://github.com/tiyd-rails-2015-08/battleship",
    concepts: ["Classes", "Assertions", "Inheritance"]},
  { name: "Battleship Day 2",
    uri: "https://github.com/tiyd-rails-2015-08/battleship",
    concepts: ["Classes", "Assertions", "Composition"]},
  { name: "Battleship Day 3",
    uri: "https://github.com/tiyd-rails-2015-08/battleship",
    concepts: ["Classes", "Assertions", "Enumerable", "Regex"]},
  { name: "Employee Reviews",
    uri: "https://github.com/tiyd-rails-2015-08/employee_reviews_project",
    concepts: ["Composition", "TDD", "Enumerable", "Regex", "Blocks"]},
  { name: "Time Entry Data Structure",
    uri: "https://github.com/tiyd-rails-2015-08/time_entry_data_structure",
    concepts: ["DB Design", "Migrations"]},
  { name: "Employee Reviews w/ DB",
    uri: "https://github.com/tiyd-rails-2015-08/employee_reviews_with_db",
    concepts: ["Migrations", "Unit Testing", "ActiveRecord"]},
  { name: "Legacy Associations",
    uri: "https://github.com/tiyd-rails-2015-08/legacy_associations_and_validations",
    concepts: ["Associations", "Validations", "branch", "merge"]},
  { name: "Weather Report",
    uri: "https://github.com/tiyd-rails-2015-08/weather_report",
    concepts: ["Consuming APIs", "Token Security", "HTTP", "JSON"]},
  { name: "Voting API",
    uri: "https://github.com/tiyd-rails-2015-08/voting_api",
    concepts: ["Producing APIs", "HTTP Verbs", "MVC", "Controllers", "The Router", "Controller Testing"]},
  { name: "Build Your Own API",
    uri: "https://github.com/tiyd-rails-2015-08/novel_api",
    concepts: ["Producing APIs", "Consuming APIs", "JSON", "HTTP Verbs", "Seeds", "Fixtures", "Environments", "Deployment"]},
  { name: "CSS Reverse Engineering",
    uri: "https://github.com/tiyd-rails-2015-08/css_reverse_engineering",
    concepts: ["HTML", "CSS"]},
  { name: "Recreate GitHub Profile",
    uri: "https://github.com/tiyd-rails-2015-08/github_profile",
    concepts: ["ERB", "HTML Forms", "Git", "reset", "filter-branch"]},
  { name: "Wallet",
    uri: "https://github.com/tiyd-rails-2015-08/wallet",
    concepts: ["REST", "Scaffold", "Integration Testing"]},
  { name: "Health Tracker",
    uri: "https://github.com/tiyd-rails-2015-08/health_tracker",
    concepts: ["MVC", "REST", "The Router", "ERB", "Testing", "HTML", "CSS", "Helpers", "Partials"]},
  { name: "Restaurant Menu",
    uri: "https://github.com/tiyd-rails-2015-08/restaurant_menu",
    concepts: ["Asset Pipeline", "Deployment", "SCSS/Bootstrap"]},
  { name: "Teacherbook",
    uri: "https://github.com/tiyd-rails-2015-08/teacherbook",
    concepts: ["Authentication", "Session"]},
  { name: "Gradebook",
    uri: "https://github.com/tiyd-rails-2015-08/gradebook",
    concepts: ["Session", "Authorization", "Scope"]},
  { name: "Survey Opossum",
    uri: "https://github.com/tiyd-rails-2015-08/survey_opossum",
    concepts: ["ERB", "Nested Attributes", "Authentication", "REST", "Deployment", "Testing"]},
  { name: "Add JavaScript",
    uri: "https://github.com/tiyd-rails-2015-08/add_javascript",
    concepts: ["JS Basics"]},
  { name: "Add jQuery",
    uri: "https://github.com/tiyd-rails-2015-08/add_jquery",
    concepts: ["JS Basics", "jQuery"]},
  { name: "Auction Site",
    uri: "https://github.com/tiyd-rails-2015-08/auction_ajax",
    concepts: ["JS Basics", "jQuery", "AJAX"]},
  { name: "Todo List",
    uri: "https://github.com/tiyd-rails-2015-08/todo_app",
    concepts: ["JS Basics", "jQuery", "AJAX", "Asset Pipeline"]},
  { name: "Survey Opossum Plus SQL",
    uri: "https://github.com/tiyd-rails-2015-08/survey_opossum_plus_sql",
    concepts: ["SQL", "Indices", "AREL"]},
  { name: "Delayed Mailer",
    uri: "https://github.com/tiyd-rails-2015-08/delayed_mailer",
    concepts: ["Mailers", "Background Processing"]},
  { name: "Reports on S3",
    uri: "https://github.com/tiyd-rails-2015-08/reports_on_s3",
    concepts: ["File Uploads"]},
  { name: "Take a Ticket",
    uri: "https://github.com/tiyd-rails-2015-08/take_a_ticket",
    concepts: ["Rails", "Web App Patterns"]}
]

assignment_hashes.each do |hash|
  a = Assignment.create!(name: hash[:name],
             uri: hash[:uri])
  hash[:concepts].each do |concept_name|
    puts concept_name
    a.coverages.build(concept_uuid: Concept.where(name: concept_name).first.uuid)
  end
  a.save!
end

s = Student.create!(name: "Student 1", email: "student@dev.null")
