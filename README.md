# README

This is an example Rails application set up to run some tests on the given class `LogRequestsMiddleware`.
The relevant files for the assessment are:
- src: [log_requests_middleware.rb](lib/middleware/log_requests_middleware.rb)
- test: [log_requests_middleware_spec.rb](spec/lib/middleware/log_requests_middleware_spec.rb)
- conf: [config/application.rb](config/application.rb)

- Uses ruby 3.2.2 and rails 7.1.2.
- Uses Postgres so that we can leverage its JSONB data type.

## Setup

`bin/rails db:create`

## To Run

`bin/rails server` then navigate to [http://127.0.0.1:3000]

Not recommended as the `LogRequestsMiddleware` has not been changed to handle the possible errors.

## Testing

`bundle exec rspec`
