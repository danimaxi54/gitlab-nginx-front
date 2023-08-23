#FROM node:alpine as build
#WORKDIR /app
#COPY . .
#RUN npm install
#RUN npm run build
#
#FROM nginx:stable-alpine
#COPY --from=build /app/dist /var/www/nginx-ci-cd-frontend
#EXPOSE 80
#CMD ["nginx", "-g", "daemon off;"]

#FROM nginx:alpine
#COPY /build /var/www/nginx-ci-cd-frontend

#FROM nginx:1.18
#COPY build /var/www/nginx-ci-cd-frontend

# pull official base image
#FROM node:14.19.0-alpine as build
#
#COPY package.json package-lock.json ./
#
#RUN npm install && mkdir /frontend && mv ./node_modules ./frontend
#
#WORKDIR /frontend
#
#COPY . .
#
#RUN npm run build
#
#
#FROM nginx:1.17-alpine
#
#RUN rm -rf /var/www/nginx-ci-cd-frontend
#
#COPY --from=build /frontend/build /var/www/nginx-ci-cd-frontend

#FROM node:alpine as build
#WORKDIR /app
#
#COPY . /app/
#
#RUN npm install
#RUN npm run build
#
#FROM nginx:1.16.0-alpine
#COPY --from=build /app/build /usr/share/nginx/html
#RUN rm /etc/nginx/conf.d/default.conf
#COPY nginx/nginx.conf /etc/nginx/conf.d


# ИСПОЛЬЗОВАЛ ЭТУ ПОСЛЕДНЮЮ ВЕРСИЮ
# Set the base image to node:12-alpine
FROM node:alpine as build

# Specify where our app will live in the container
WORKDIR /app

# Copy the React App to the container
COPY . /app/

# Prepare the container for building React
RUN npm install
# We want the production version
RUN npm run build

# Prepare nginx
FROM nginx:1.16.0-alpine
COPY --from=build /app/build /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/conf.d
#
## Fire up nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
