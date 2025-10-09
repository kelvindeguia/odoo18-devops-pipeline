FROM odoo:18.0

WORKDIR /mnt/extra-addons
COPY ./addons /mnt/extra-addons

EXPOSE 8069

CMD ["odoo"]
