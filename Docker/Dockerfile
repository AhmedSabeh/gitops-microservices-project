# Use Nginx official image
FROM nginx:alpine

# Copy the website files to Nginx's default html folder
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 5000

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]

