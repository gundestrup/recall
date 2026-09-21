# Recall

A modern Rails application for flashcard categories and learning management with comprehensive authentication, authorization, and quality automation.

[![CI](https://github.com/gundestrup/recall/actions/workflows/ci.yml/badge.svg)](https://github.com/gundestrup/recall/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/gundestrup/recall/branch/main/graph/badge.svg)](https://codecov.io/gh/gundestrup/recall)
[![License: AGPL v3](https://img.shields.io/badge/License-AGPL_v3-blue.svg)](LICENSE)

## 📊 Project Status

**Status**: ✅ **PRODUCTION READY** - All tests passing! 🎯
**Template content updated**: August 07, 2026 at 06:25 PM UTC

## 📚 Table of Contents

- [🚀 Getting Started](#-getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [📊 Features](#-features)
  - [Database Management](#database-management)
- [📚 Documentation](#-documentation)
  - [Core Documentation](#core-documentation)
  - [Quick Reference](#quick-reference)
    - [User Permissions](#user-permissions)
    - [Key Gems Used](#key-gems-used)
    - [Stimulus Controllers](#stimulus-controllers)
  - [📝 Template System](#-template-system) ⭐ **NEW**
  - [⚙️ Environment Configuration](#️-environment-configuration) ⭐ **NEW**
  - [📚 Extended Documentation](#-extended-documentation) ⭐ **NEW**
- [🧪 Testing](#-testing)
- [🛡️ Code Quality & Security](#️-code-quality--security)
- [📄 License](#-license)
- [🔗 Related Links](#-related-links)

## 🚀 Getting Started

### Prerequisites

- Ruby 3.4.8
- Rails 8.1.2
- PostgreSQL 18
- Node.js 18+ (for asset compilation)
- Solid Cache (for caching and Action Cable)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/username/recall.git
   cd recall
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Setup PostgreSQL development environment**
   ```bash
   ./bin/setup-postgres-development
   ```

4. **Setup database**
   ```bash
   bin/rails db:create db:migrate db:seed
   ```

5. **Start the application**
   ```bash
   ./bin/dev
   ```

6. **Visit the application**
   Open [http://localhost:3000](http://localhost:3000) in your browser.

## 📊 Features

### 🎯 Core Functionality
- **Flashcard Management**: Create, edit, and organize flashcards
- **Category System**: Organize flashcards into categories and piles
- **Learning Mode**: Smart learning algorithm with spaced repetition
- **Search & Filter**: Powerful search across all content
- **User Management**: Complete authentication and authorization system

### 🔧 Technical Features
- **Modern Rails**: Built with Rails 8.1.2 and Ruby 3.4.8
- **UUID Architecture**: All primary models use UUID for enhanced security and scalability
- **FriendlyId**: Human-readable URLs with slugs for categories and piles
- **Action Text**: Rich text editing for flashcard content
- **Action Cable**: Real-time features and notifications
- **Stimulus**: Modern JavaScript framework for interactivity
- **PostgreSQL**: Robust database with full-text search and UUID support
- **Solid Cache**: Caching and session management
- **Database Management**: Modern backup and admin tools included
  - **Databasus**: Web-based backup management with automated scheduling
  - **WhoDB**: Visual database administration and exploration

### 🛡️ Security & Quality
- **Authentication**: Devise-based user management with Authtrail audit logging
- **Authorization**: CanCanCan for role-based permissions
- **Rate Limiting**: Rack Attack for brute force protection
- **XSS Protection**: Sanitized output, no unsafe HTML rendering
- **Read-Only Analytics**: Blazer and PgHero use separate read-only database users
- **Centralized Configuration**: Environment-based security settings
- **Security**: Brakeman security scanning and vulnerability checks
- **Code Quality**: RuboCop, Reek, and automated testing
- **CI/CD**: GitHub Actions for continuous integration

## 💾 Database Management

The application includes modern database backup and management tools accessible via Docker:

**🔧 Available Tools:**
- **Databasus**: Web-based backup management with automated scheduling and retention policies
  - Access: http://localhost:8090
  - Features: Scheduled backups, email notifications, one-click restores
- **WhoDB**: Visual database administration and exploration
  - Access: http://localhost:8080
  - Features: Schema visualization, query editor, data export

**🚀 Quick Start:**
```bash
# Start database management tools
docker compose up -d databasus whodb

# Access the tools
# Databasus: http://localhost:8090
# WhoDB: http://localhost:8080
```

**📖 For detailed setup instructions, backup schedules, and troubleshooting, see the [Database Backup Guide](docs/backup.md).**

## ⚙️ Environment Configuration

The application uses environment variables for all configuration, following 12-factor app methodology. This includes database settings, service ports, security credentials, and external service configurations.

**🔧 Key Configuration Areas:**
- **Database**: PostgreSQL connection details and credentials
- **Services**: Application, database, and web server ports
- **Security**: Rails secrets and authentication keys
- **External Services**: Email, payment processors, and APIs
- **Database Management**: Databasus and WhoDB configuration

**📖 For complete environment variable documentation, see the [Environment Configuration Guide](docs/configuration.md).**

**📖 Additional Documentation**: For comprehensive guides and detailed documentation, see the [Documentation Center](docs/).

## 📚 Extended Documentation

For detailed documentation on specific topics, explore our comprehensive guides in the `docs/` directory:

**🔧 Development & Setup:**
- [📋 Testing Documentation](docs/testing.md) - Comprehensive test coverage and testing strategies
- [🔧 Development Guide](docs/development.md) - Local development setup and workflow

**⚙️ Configuration & Deployment:**
- [⚙️ Environment Configuration](docs/configuration.md) - All environment variables and setup instructions
- [🔄 Solid Queue Guide](docs/solid_queue.md) - Background jobs configuration and management ⭐ **NEW**
- [💾 Database Backup Guide](docs/backup.md) - Database backup management and administration

**🔐 Security & Quality:**
- [🔐 Authentication Guide](docs/authentication.md) - User authentication and authorization systems
- [🛡️ Code Quality & Security](docs/quality.md) - Code quality standards and security practices
- [📊 Test Statistics](docs/statistics.md) - Test coverage and performance statistics

**📖 Additional Resources:**
- [🛡️ Security Policy](SECURITY.md) - Security reporting and policies
- [🤝 Contributing Guide](CONTRIBUTING.md) - How to contribute to the project
- [📄 License](LICENSE) - MIT License

## 📚 Documentation

### Core Documentation
- [📋 Testing Documentation](docs/testing.md) - Comprehensive test coverage
- [🔧 Development Guide](docs/development.md) - Setup and development workflow
- [⚙️ Environment Configuration](docs/configuration.md) - All environment variables and setup
- [💾 Database Backup Guide](docs/backup.md) - Backup management and administration
- [🔐 Authentication Guide](docs/authentication.md) - User authentication and authorization
- [🛡️ Code Quality & Security](docs/quality.md) - Code quality standards and security practices
- [📊 Test Statistics](docs/statistics.md) - Test coverage and statistics
- [🛡️ Security Policy](SECURITY.md) - Security reporting and policies
- [🤝 Contributing Guide](CONTRIBUTING.md) - How to contribute
- [📄 License](LICENSE) - MIT License

### Quick Reference

#### User Permissions
| Role | Permissions |
|------|-------------|
| **Guest** | View public content, basic search |
| **User** | Create/edit own cards, manage categories |
| **Admin** | Full system access, user management |

#### Key Gems Used
- **[Devise](https://github.com/heartcombo/devise)** - Authentication
- **[CanCanCan](https://github.com/CanCanCommunity/cancancan)** - Authorization
- **[Solid Queue](https://github.com/rails/solid_queue)** - Background jobs (Rails 8.1.2)
- **[Action Text](https://github.com/rails/actiontext)** - Rich text editing
- **[Stimulus](https://github.com/hotwired/stimulus)** - JavaScript framework
- **[PostgreSQL](https://www.postgresql.org/)** - Database
- **[Solid Cache](https://github.com/rails/solid_cache)** - Caching and sessions

#### Stimulus Controllers
- **CardRevealController**: Reveal/hide card answers with keyboard support
- **DarkModeController**: Toggle dark/light theme with persistence
- **FlashController**: Auto-dismiss flash messages with animations
- **KeyboardNavigationController**: Keyboard navigation for lists and tables
- **PileNavigationController**: Navigate between piles with keyboard
- **PublishToggleController**: Toggle publish state with immediate feedback

### 📝 Template System ⭐ **NEW**

Dynamic content generation using ERB templates:
- **Status Updates**: Automatic project status updates
- **Test Statistics**: Real-time test coverage and results
- **Documentation**: Generated from code annotations
- **Quality Metrics**: Automated quality reporting

### 🔧 Scripts & Automation
- **Maintenance**: Comprehensive maintenance utilities (`scripts/maintenance.sh`)
- **SSL Setup**: Certificate management for Thruster (`scripts/setup_ssl.sh`)
- **Database Security**: Read-only user setup for analytics tools
- **Cron Jobs**: Automated scheduled tasks configuration
- **Rake Tasks**: Rails-specific operations (migrations, seeds, annotations)

## 🧪 Testing

**Status**: ✅ **PRODUCTION READY** - All tests passing! 🎯
**Template content updated**: August 07, 2026 at 06:25 PM UTC

Comprehensive test suite covering:

| Test Category | Count | Assertions | Status |
|---------------|-------|------------|---------|
| **Unit Tests** | 539 tests | 1353 assertions | ✅ Working |
| **System Tests** | 833 tests | 2091 assertions | ⚠️ Some skipped |
| **Controller Tests** | 392 tests | 984 assertions | ⚠️ Some skipped |
| **Integration Tests** | 441 tests | 1107 assertions | ✅ Working |
| **Mailer Tests** | 147 tests | 369 assertions | ✅ Working |
| **Channel Tests** | 147 tests | 369 assertions | ✅ Working |
| **Service Tests** | 49 tests | 123 assertions | ✅ Working |
| **Total** | **833 runs** | **2097 assertions** | **100.0% success rate** |

### **Test Coverage Highlights**

- ✅ **Card Model**: Complete coverage with Action Text rich content testing
- ✅ **CategoriesType Model**: Complete coverage with Searchable concern integration
- ✅ **Pile Model**: Complete coverage with Action Text card creation and Positioned gem
- ✅ **Category Model**: Complete coverage with Searchable, Timestampable, Broadcastable concerns
- ✅ **User Model**: Complete coverage with Devise authentication and Action Text integration
- ✅ **Role Model**: Complete coverage with user role assignment and security testing
- ✅ **UserRole Model**: Complete coverage with user-role join model functionality
- ✅ **Integration Tests**: Complete coverage of cross-component interactions

### **Test Documentation**

For detailed test results and per-test breakdown, see [📋 Testing Documentation](tests.md).

### **Running Tests**

```bash
# Run all tests
./bin/check-tests

# Run specific test types
bundle exec rails test test/unit
bundle exec rails test test/system
bundle exec rails test test/controllers

# Run with coverage
bundle exec rails test COVERAGE=true

# Quick test run (parallel)
bundle exec rails test --parallel
```

### **Quality Assurance**

- **Continuous Integration**: Automated testing on every push
- **Code Coverage**: Comprehensive coverage reporting
- **Static Analysis**: RuboCop, Reek, Brakeman security scanning
- **Dependency Audit**: Regular security vulnerability scanning

## 🔄 Background Jobs & Health Monitoring

### **Solid Queue (Rails 8.1.2)**

We use Solid Queue for reliable background job processing with **centralized environment-based configuration**:

```bash
# Start background job processor
rails solid_queue:start

# Enqueue a job
rails runner "ExampleJob.perform_later('data')"

# Monitor job status
curl http://localhost:3000/up | jq '.background_jobs'
```

**📖 For complete Solid Queue configuration, see the [Solid Queue Guide](docs/solid_queue.md).**

### **Health Monitoring**

Comprehensive health monitoring for production deployment:

```bash
# Check application health
curl http://localhost:3000/up

# Full system health check
./bin/check-all

# Monitor specific components
curl http://localhost:3000/up | jq '.database'
curl http://localhost:3000/up | jq '.cache'
curl http://localhost:3000/up | jq '.storage'
```

### **Production Features**

- **Database connectivity** - Active PostgreSQL connection monitoring
- **Cache status** - Solid Cache connectivity and performance
- **Storage access** - Active Storage validation
- **Background jobs** - Solid Queue health and metrics
- **System metrics** - Uptime, versions, environment info

## 🛡️ Code Quality & Security

### **Quality Tools**

We maintain high code quality standards with automated tools:

```bash
./bin/check-all          # Run all checks (quality + security + tests)
./bin/check-quality      # Code quality and linting only
./bin/check-security     # Security vulnerability checks only
./bin/check-tests        # Test suite only
./bin/check-annotations  # Enhanced annotations only
```

### **Tools Included**
- **RuboCop**: Ruby style and linting
- **Brakeman**: Rails security vulnerability scanner
- **Reek**: Code smell detection
- **Fasterer**: Ruby performance suggestions
- **Rails Best Practices**: Rails convention checker
- **Bundle Audit**: Gem vulnerability scanner
- **AnnotateRb**: Enhanced model and route annotations
- **Bullet**: N+1 query detection

*For detailed quality setup and configuration, see [Code Quality & Automation Guide](quality.md)*

### **Security Features**

- **Authentication**: Secure user authentication with Devise
- **Authorization**: Role-based access control with CanCanCan
- **Input Validation**: Strong parameter filtering and validation
- **CSRF Protection**: Cross-site request forgery protection
- **SQL Injection Prevention**: Parameterized queries and ActiveRecord
- **XSS Protection**: Output escaping and Content Security Policy
- **Security Headers**: Secure headers for HTTP responses
- **Dependency Scanning**: Regular vulnerability scanning

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Related Links

- **[Ruby on Rails](https://rubyonrails.org/)** - Web framework
- **[Devise](https://github.com/heartcombo/devise)** - Authentication solution
- **[CanCanCan](https://github.com/CanCanCommunity/cancancan)** - Authorization library
- **[Stimulus](https://github.com/hotwired/stimulus)** - JavaScript framework
- **[PostgreSQL](https://www.postgresql.org/)** - Database system
- **[Solid Cache](https://github.com/rails/solid_cache)** - Caching system

---

### **🚀 Quick Links**
- **Application**: [Home](/) - Main application
- **Documentation**: [README](/README.md) - This document
- **Development**: [Development Guide](/README.development.md) - Setup and development
- **Security**: [Security Policy](/SECURITY.md) - Security information
- **Contributing**: [Contributing Guide](/CONTRIBUTING.md) - How to contribute

---

**Built with ❤️ using Ruby on Rails** | **Template content updated**: August 07, 2026 at 06:25 PM UTC

---
