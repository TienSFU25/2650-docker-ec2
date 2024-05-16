# Build the React Application (frontend)
FROM node:16 as build-stage
WORKDIR /client
COPY ./client/package*.json ./
RUN npm install
COPY ./client/ .
RUN npm run build

# Setup the Express Server (backend)
FROM node:16 as production-stage
WORKDIR /main

# Copy the build output from the previous stage
COPY --from=build-stage /client/dist /main/public

# Copy backend files
COPY ./backend/package*.json ./
RUN npm install --production
COPY ./backend/ .

EXPOSE 3000
CMD ["node", "server.js"]