# Use the official Node.js image as the build stage
FROM node:18 AS build

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy package.json and yarn.lock (or package-lock.json) files
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install

# Copy the rest of the application code
COPY . .

# Build the application
RUN yarn build

# Use a lightweight web server to serve the build files
FROM nginx:alpine

# Copy the build files from the build stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 for the web server
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
