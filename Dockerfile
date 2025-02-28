# Line 3 initialises build stage and sets base image called build
# using node here as base image
FROM node:21-alpine3.18 AS build
# Line 5 which port the app will listen on
EXPOSE 80
# Line 8 -if directory does not exist, WORKDIR creates it
# Line 8 path is relative to current working directory
WORKDIR /app
# Line 10 copy all files from current location to workdir
COPY . .
# Line 12 install node libraries
RUN npm install
# Line 14 same as ng build :-)
RUN npm run build
# Line 16 add another image to build base, the nginx web server
FROM nginx:alpine
# Line 18 copy the built application to the nginx root dir at /html
COPY --from=build /app/dist/hello-world/browser /usr/share/nginx/html