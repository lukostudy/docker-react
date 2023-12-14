# two phase process
# 1: build the app
# 2: pass the result to the production server and run it

# 1:
# first part of this Dockerfile
# builds a container
# to build the node.js app
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# 2:
# next block starts here as we have a second FROM
FROM nginx
# the following EXPOSE is just to communicate that the
# container should be listening at port 80
# this is information only - Travis uses that
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# we don't need to start up nginx because
# the default command from nginx base image does that


# docker build with this docker file should produce 
# a production container