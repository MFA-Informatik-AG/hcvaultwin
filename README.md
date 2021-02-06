## VAULT
Vault is a tool from Hashicorp for securely accessing secrets. A secret is anything that you want to tightly control access to, such as API keys, passwords, certificates, and more. For more information, please see:

[Hashicorp Vault Project](https://www.vaultproject.io/ "Hashicorp Vault Project")

## Dockerfile
The Dockerfile downloads and installs OpenSSL and Hashicorp Vault from Chocolatley on a  Windows Server Core LTSC 2019 Docker image

### Docker Run

#### Vault within the Container

docker run -d -p 8200:8200 --cap-add=IPC_LOCK --name hckv aeschneider/hcvaultwin

#### Vault using volumes on the host

docker run -d -p 8200:8200 --cap-add=IPC_LOCK --name hckv -v c:\vault\logs:c:\vault\logs:rw -v c:\vault\file:c:\vault\file:rw -v c:\vault\config:c:\vault\config:rw aeschneider/hcvaultwin

#### Accessing Vault
Connect with your browser to https://localhost:8200 to access Vault.

