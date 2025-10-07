# Use Odoo 18 base image
FROM odoo:18.0

# Set working directory inside the container
WORKDIR /mnt/extra-addons

# Copy your custom modules into the container
COPY ./addons /mnt/extra-addons

# Expose Odoo port
EXPOSE 8069

# Run Odoo when the container starts
CMD ["odoo"]
