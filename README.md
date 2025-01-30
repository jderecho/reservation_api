This is a Ruby on Rails-based API that allows users to create reservations.

#### Requirements

- Ruby version: 3.x.x
- Rails version: 7.x.x
- Database: PostgreSQL  


#### System dependencies
Ensure you have the following installed:
- PostgreSQL

#### Configuration
1. Clone the repository:
```
git clone https://github.com/jderecho/reservation-api.git
cd reservation-api
```

<br>

#### Running the Application with Docker Compose
1. Start the application:
```
docker-compose up --build
```

2. The application will be available at:
http://localhost:3000

3. To stop the application:
```
docker-compose down
```

<br>

#### Running the Test Suite
To run tests inside the Docker container:
```
docker-compose run web bin/rails db:setup
docker-compose run web bundle exec rspec --format documentation
```

<br>

#### API Documentation
API endpoints and documentation can be found at:
http://localhost:3000/api-docs
