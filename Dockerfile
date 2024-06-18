# Use the official Elixir image
FROM elixir:latest

# Install Hex package manager
RUN mix local.hex --force && \
    mix local.rebar --force

# Install Phoenix
RUN mix archive.install hex phx_new --force

# Set the working directory
WORKDIR /app

# Copy the rest of the application
COPY . .

# Install Elixir dependencies
RUN mix deps.get

# Compile the application
RUN mix deps.compile

# Expose the Phoenix port
EXPOSE 4000

# Set environment variable for interactive Elixir
ENV MIX_ENV=dev

# Command to run the Phoenix server
CMD ["mix", "phx.server"]
