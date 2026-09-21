source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.1.2"
# Ensure propshaft is present
gem "propshaft"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.6.3"
# Use postgresql search for Active Record
gem "pg_search", "~> 2.3.7"
# Use csv for data import/export (required by Ruby 3.4+)
gem "csv"
# Load environment variables from .env files
gem "dotenv-rails", groups: [ :development, :test ]
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Authentication
gem "devise", "~> 5.0.0"
# Authentication i18n
gem "devise-i18n", "~> 1.16.0"
# Authorization
gem "cancancan"
# Rate limiting and attack protection
gem "rack-attack"
# Authentication audit trail
gem "authtrail"
# Pagination
gem "kaminari"
# Background jobs
gem "solid_queue"
# Solid Cable for Action Cable (replaces Redis)
gem "solid_cable", "~> 4.0"
# Solid Cache for durable PostgreSQL-backed caching
gem "solid_cache", "~> 1.0"
# Thruster web server (replaces Nginx)
gem "thruster", "~> 0.1.18"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Tailwind stack
gem "tailwindcss-rails", "~> 4.4"
gem "tailwindcss-ruby", "~> 4.1", ">= 4.1.18"
# Flowbite
gem "flowbite", "~> 3.1.2"

# lucide
gem "lucide-rails", "~> 0.7.1"

# counter culture
gem "counter_culture", "~> 3.2"

# Act as list replacement
gem "positioning"

# FriendlyID for human-readable URLs
gem "friendly_id", "~> 5.6"

# Sitemap
gem "sitemap_generator", "~> 7.1"

# Structured JSON logging for production
gem "logstasher"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"
# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", "~> 1.25", require: false

# PgHero  performance
gem "pghero", "~> 4.0"

# Notable for slow query and request logging
gem "notable"

# Blazer for business intelligence and analytics
gem "blazer"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", "~> 8.0.2", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  # Security audit for gem dependencies
  gem "bundler-audit", require: false

  # Code smell detection
  gem "reek", require: false

  # Ruby performance suggestions
  gem "fasterer", require: false

  # Rails best practices checker
  gem "rails_best_practices", require: false

  # Performance-focused RuboCop extension
  gem "rubocop-performance", require: false

  # bullet
  gem "bullet", require: false

  # flay
  gem "flay", require: false

  # flog
  gem "flog", require: false

  # Translation management and static analysis
  gem "i18n-tasks", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Generate Entity-Relationship Diagrams
  gem "rails-erd"

  # annotation
  gem "annotaterb", "~> 4.24", require: false
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver",  "~> 4.46"
  # test proof optimizer
  gem "test-prof", "~> 1.0"
  # Database_clean active records when testing
  gem "database_cleaner-active_record", "~> 2.2"
  # Code coverage reporting
  gem "simplecov", "~> 1.0", require: false
  gem "simplecov-cobertura", "~> 4.0", require: false
end
