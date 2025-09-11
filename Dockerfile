# Step 1: Use official Node.js image to build the application
FROM node:16 AS build

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build the React app for production
RUN npm run build

# Step 2: Set up the production environment to serve the app
FROM nginx:alpine

# Copy the build output from the previous build stage to the Nginx server
COPY --from=build /app/build /usr/share/nginx/html

# Expose the port that Nginx will listen on
EXPOSE 80

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]
