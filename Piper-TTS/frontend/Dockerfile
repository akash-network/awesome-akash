FROM nginx:alpine

# Copy HTML file
COPY index.html /usr/share/nginx/html/index.html

# Copy logo file
COPY akash-logo.png /usr/share/nginx/html/akash-logo.png

# Copy custom nginx config (optional)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1
