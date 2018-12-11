# Build Phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
# It's a good practice to keep COPY here even though docker-compose is handling volumes
COPY . .
RUN ["npm", "run", "build"]

# Run Phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html