# Stage 1: Build Image
FROM node:18-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Production Server (Nginx)
FROM nginx:alpine
# Copy hasil build dari stage 1 ke folder default nginx
COPY --from=builder /app/build /usr/share/nginx/html
# Nginx secara otomatis akan jalan di port 80
EXPOSE 80
