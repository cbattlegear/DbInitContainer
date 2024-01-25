FROM ubuntu as final
RUN apt-get update && apt-get install -y curl gnupg2 && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg && curl https://packages.microsoft.com/config/debian/12/prod.list > /etc/apt/sources.list.d/mssql-release.list && apt-get update && ACCEPT_EULA=Y apt-get install -y wget msodbcsql18 mssql-tools18
WORKDIR /restore
COPY . .
RUN chmod +x restore.sh
CMD ["bash", "-c", "./restore.sh"]