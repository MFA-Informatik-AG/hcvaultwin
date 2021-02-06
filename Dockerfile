FROM mcr.microsoft.com/windows/servercore:ltsc2019

ARG CERT_SUBJECT="/CN=localhost/O=myorg/C=CH"
ARG CERT_DAYS=365
ARG VAULT_ADDRESS="0.0.0.0:8200"
ARG VAULT_LOGLEVEL="Info"

# installation of openssl and vault through chocolatey
# creation of a self signed certificate to support at least transport encryption
# ensure you map the volumes for log, data and config to your host
RUN powershell -Command \
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) ; \
	choco feature enable -n=allowGlobalConfirmation ; \
	choco install openssl ; \
	choco install vault ; \
	mkdir -p c:\vault ; \
	mkdir -p c:\vault\logs ; \
	mkdir -p c:\vault\config ; \
	mkdir -p c:\vault\file ; \
	cd c:\vault\config ; \
	c:\Program` Files\OpenSSL-Win64\bin\openssl.exe req -newkey rsa:2048 -nodes -keyout key.pem -x509 -days %CERT_DAYS% -out certificate.pem -subj '%CERT_SUBJECT%' ; \
	Set-Content -Path c:\vault\config\vault.json -Value '{\"storage\":{\"file\":{\"path\":\"c:\\vault\\file\"}},\"listener\":{\"tcp\":{\"address\":\"%VAULT_ADDRESS%\",\"tls_disable\":\"0\",\"tls_cert_file\":\"c:\\vault\\config\\certificate.pem\",\"tls_key_file\":\"c:\\vault\\config\\key.pem\",\"default_lease_ttl\":\"168h\",\"max_lease_ttl\":\"720h\"}},\"log_level\":\"%VAULT_LOGLEVEL%\",\"ui\":true}'


EXPOSE 8200

ENTRYPOINT ["vault.exe"]

CMD ["server", "-config=c:\\vault\\config\\vault.json"]
