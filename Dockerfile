# Base image
FROM ruby:3.1.2

# Set environment variables
ENV APP_HOME /app
ENV BUNDLE_PATH /gems
ENV NODE_ENV production
ENV RAILS_ENV production
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_SERVE_STATIC_FILES true

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Create and set working directory
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the app
COPY . .

# Expose the port
EXPOSE 3000

# Start the server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000", "-e", "production"]
