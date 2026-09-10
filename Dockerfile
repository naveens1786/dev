FROM nginx:alpine

# Copy React production build
COPY build/ /usr/share/nginx/html/

# Configure Nginx to listen on port 3000
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 3000

CMD ["nginx", "-g", "daemon off;"]
