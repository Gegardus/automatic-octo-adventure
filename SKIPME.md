# Aligned SUV

### Overview

The Aligned SUV (Start-Up Visa) Platform aims to be a comprehensive web application designed to facilitate and streamline the application process for applicants interested in Start-Up Visa program. The platform caters to multiple user roles, including Anonymous Users (Anon), Admins, and Applicants. It offers a range of features and functionalities to ensure a smooth and efficient application journey.

### Other info

- [Scope](docs/scope.md) - Scope document for this project
- [Phase 1](docs/phase-1.md) - Phase 1 milestone for this project
- [Flow chart](docs/flow_chart.pdf) - Basic flow chart for first few interactions
- [Zoom call with aligned](https://we.tl/t-1kzzYXFWCU) - Initial call with Aligned
- [Powerpoint from Zoom call](docs/program_design.pdf) - Powerpoint from Initial call with Aligned

## Prerequisites

Before you begin, ensure you have met the following requirements:

- **Ruby**: Version 3.4.2 or newer.
- **Rails**: Version 7.1 or newer.
- **Node.js**: Required for Yarn and Webpack.
- **Yarn**: Manages JavaScript dependencies.
- **PostgreSQL**: This project uses PostgreSQL.

## Setup

To set up this project, follow these steps:

1. **Clone the repository:**

  ```bash
  git clone https://github.com/CosmicDevelopmentGE/aligned-suv.git
  ```

2. **Install Ruby dependencies:**

  ```bash
  bundle install
  ```

3. **Install JavaScript dependencies:**

  ```bash
  yarn install
  ```

4. **Database setup:**

  Set up the database and seed it with fixtures:

  ```bash
  scripts/nuke
  ```

  If you encounter permission issues, make the script executable:

  ```bash
  chmod +x scripts/nuke
  ```

5. **Watch and compile css and js:**

  ```bash
  yarn dev
  ```

6. **Start the server:**

  ```bash
  rails server
  ```

  Access the application at `http://localhost:3000`.

## Front end

### [Tailwind CSS](https://tailwindcss.com/docs)
This project incorporates Tailwind CSS is used for the main front end framework.

### [Hyper-UI](https://www.hyperui.dev/)

### [Preline](https://preline.co/docs/index.html)

## Additional Information

- **Running Tests:** Execute all tests with `rails test`.
- **Test Coverage:** Execute tests with `COVERAGE=models rails test:models` or `COVERAGE=controllers rails test:controllers` to run a coverage report
for model or controller coverage. More information is available on [simplecov](https://github.com/simplecov-ruby/simplecov)
- **Code Quality:** RuboCop ensures code quality. Run `rubocop` to check for styling offenses.
- **Github Actions:** This codebase uses GitHub Actions to run tests and coverage in master and on pull requests
