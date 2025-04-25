# Use official Node.js 14 base image
FROM node:14

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (if any)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app source code
COPY . .

# Expose the app on port 3000 (optional, based on app config)
EXPOSE 5050

# Command to run the app
CMD ["npm", "start"]
