This is a Ruby on Rails-based API that allows users to create reservations.

#### Requirements

- Ruby version: 3.2.5 +
- Rails version: 7.2.x +
- Database: PostgreSQL  


#### System dependencies
Ensure you have the following installed:
- Docker & Docker Compose
https://docs.docker.com/engine/install/
https://docs.docker.com/compose/install/

#### Configuration
1. Clone the repository:
```
git clone git@github.com:jderecho/reservation_api.git
cd reservation_api
```

<br>

#### Running the Application with Docker Compose
1. Start the application:
```
docker-compose up --build
```
2. Setup Local Master Key
```
docker-compose run web bin/rails credentials:edit
```

3. The application will be available at:
http://localhost:3000

4. To stop the application:
```
docker-compose down
```

<br>

#### Running the Test Suite
To run tests inside the Docker container:
```
docker-compose run web bin/rails db:reset
docker-compose run web bundle exec rspec --format documentation
```

<br>

#### API Documentation
API endpoints and documentation can be found at:

RUN db:seed to setup development user
User credential
Username: admin
password: password

http://localhost:3000/api-docs

#### Setting Up Development User
To set up a development user, run the following command:
```
docker-compose run web bin/rails db:seed
```

##### User Credentials
Once the seeding is complete, you can log in using the following credentials:
- Username: admin
- Password: password

Use these credentials to access the application in development mode.