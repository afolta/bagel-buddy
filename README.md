# Bagel Buddy

A Rails application that allows a user to locate bagel shops within a given area.

## Dependencies:
- The React frontend application for this application is located here [Bagel Buddy Frontend](https://github.com/afolta/bagel-buddy-frontend)

## Setup
### Clone the repo

- `cd bagel-buddy`

- `bin/setup`

- To work with Google's place's API, you will need an API key
- [Create a new API key](https://developers.google.com/maps/documentation/places/web-service/cloud-setup) or reach out to @afolta to temporarily borrow a key. 

- To start the application:
  `rails server`
  
- To work with Gool

## Integrations

### [Google Places API](https://developers.google.com/maps/documentation/places/web-service)
- The bagel shops are populated by [Google's Nearby Search API](https://developers.google.com/maps/documentation/places/web-service)
- Reviews are populated by Google's [Place Details](https://developers.google.com/maps/documentation/places/web-service/details)

### [Geocoder](https://github.com/alexreisner/geocoder)
- Converts addresses to latitude and longitude coordinates.

## Contributions:
Are very welcome. Please open a PR and submit it for review.
