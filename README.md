# Viewing Party

## Project Overview

Viewing Party is a pair-programmed entertainment project that enables users to explore movie options and create events to watch a movie with other users, leveraging the IMDb API to populate data for movies, actors, and reviews.

---
### Languages, Frameworks, and Tools used
- **Building:** Ruby, Rails, HTML, CSS, and some SQL
- **Testing:** RSpec, Capybara, ShouldaMatchers, Webmock, VCR
- **Database:** PostgreSQL
- **Consuming API:** Faraday HTTP client library

### Project Challenges
- This was my first time consuming an API with so many endpoints, so writing tests for components that interact with external APIs was challenging due to potential changes in the API's response structure or availability. Mocking API responses effectively became crucial.
- Creating the data model to accurately depict users, viewing parties, and their interconnections posed a challenge, particularly since we had to account for the future integration of movie objects and their roles within the API requests. 

### My Achievements
API Consumption:
- Developed facades, services, and POROs to abstract the process of consuming the IMDb API.
- Connected successfully with 6 different API endpoints to retrieve various movie-related data.
<img width="800" alt="Screenshot 2023-08-27 at 1 58 44 PM" src="https://github.com/westonio/viewing_party/assets/117330008/6a4c6254-cfe0-4263-b10c-066fcde3efd3">
<img width="600" alt="Screenshot 2023-08-27 at 1 56 59 PM" src="https://github.com/westonio/viewing_party/assets/117330008/15212166-1aeb-4f8f-8ac0-2f36b9d8ca38">

<br/>
<br/>

Code Organization and Refactoring:
- Separated functionality into new methods in order to uphold the Single Responsiblity Principle within the Facade, Service, and POROs, improving the maintainability and readability.
- Adhered to the RuboCop style guide for enhanced code quality.

User Authentication and Data Security:
- Implemented user registration with unique email validation.
- Utilized Rails encryption to securely store and manage API access keys.

Team Collaboration:
- Collaborated effectively with my teammate to prioritize goals and user stories.
- Engaging in pair programming throughout the project allowed me to enhance my communication skills, refine my ability to conduct independent research, and improve my time management skills in order to meet the project deadline.

---
### Features
> User Registration:
> - Users can register by providing their name and a unique email.
> - After registration, users are directed to their personalized dashboard.
  
> Dashboard:
> - Users can view their dashboard, which displays their name and provides options to discover movies and view their viewing parties.
> - The dashboard also lists existing users with links to their respective dashboards.

> Discover Movies:
> - Users can navigate to the Discover Movies page to explore top-rated movies or search for specific movies.
> - Up to 20 movie results are displayed with details such as title, vote average, and a link to the movie details page.

> Movie Details:
> - Users can view detailed information about a specific movie, including its title, vote average, runtime, genres, summary description, and cast members.
> - The movie details page also provides options to create a viewing party or return to the Discover page.

> Viewing Parties:
> - Users can create viewing parties for movies they want to watch with friends.
> - When creating a party, users can specify the duration, date, start time, and select friends to invite.
> - The party details are displayed on the user's dashboard and on the dashboards of invited friends.
> - Technical Achievements

#### Thoughts on Refactoring and Improvements
> To improve this project, I would like to:
> - Refactor the ViewingParty #create controller action to slim it up.
> - Create more robust testing for creating Viewing Parties
> - Implement User Authentication via OAuth or bcrypt
> - Implement the ability for users to add reviews and ratings for movies they watched, via the IMDb API.
> - Enhancing the overall user experience through further UI/UX improvements.

#### Contributions to this Project also made by:
- [Weston Schutt](https://github.com/westonio)

Thank you for exploring Viewing Party! This project showcases my ability to consume APIs, organize code, create user interfaces, and collaborate effectively within a team.


--- 


### Setup

1. Fork and Clone the repo
2. Navigate into the repo directory `cd viewing_party`
3. Install gem packages: `bundle install`
4. Setup the database: `rails db:{drop,create,migrate,seed}`


### Versions
- Ruby 3.2.2
- Rails 7.0.6
