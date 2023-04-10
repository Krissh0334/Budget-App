# Use Ruby 3.0.2 as the base image
FROM ruby:3.0.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set the working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock to the working directory
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy the rest of the application code to the working directory
COPY . .

# Set environment variables
ENV RAILS_ENV=production

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose port 3000
EXPOSE 3000

# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

