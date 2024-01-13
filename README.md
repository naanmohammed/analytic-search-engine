# Analytic Search Engine

## Overview

Analytic Search Engine is a Rails application that captures and analyzes search queries grouped by IP addresses within a 60-second window. The application allows tracking searches, grouping them based on similarity, and displaying analytics.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Endpoints](#endpoints)
- [Dependencies](#dependencies)
- [Contributing](#contributing)
- [License](#license)

## Features

- Capture and store search queries along with IP addresses.
- Group similar searches within a 60-second window.
- Provide analytics for grouped searches.

## Installation

### Prerequisites

- Ruby (version X.X.X)
- Ruby on Rails (version X.X.X)
- [Text gem](https://github.com/threedaymonk/text)

### Setup

Clone the repository:

   ```bash
   git clone https://github.com/naanmohammed/analytic-search-engine.git
   cd analytic-search-engine
   bundle install
   rails db:create
   rails db:migrate
   rails s
   ```

## Usage

The application provides endpoints to capture and analyze search queries. It also includes a simple frontend for interacting with the API.


## Frontend

The application includes a frontend with a real-time search feature. Users can type queries, view search results, and access analytics for IP addresses.

## Dependencies

- Ruby
- Ruby on Rails
- Text gem

## Contributing

Contributions are welcome!

## License

This project is licensed under the MIT License.
