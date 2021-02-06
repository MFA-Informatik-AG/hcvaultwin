## VAULT
Vault is a tool from Hashicorp for securely accessing secrets. A secret is anything that you want to tightly control access to, such as API keys, passwords, certificates, and more. For more information, please see:

[Hashicorp Vault Project](https://www.vaultproject.io/ "Hashicorp Vault Project")

## Dockerfile
The Dockerfile downloads and installs OpenSSL and Hashicorp Vault from Chocolatley on a  Windows Server Core LTSC 2019 Docker image

## Docker Run
There are no volumes exposed in the Dockerfile. You can run the container directly or mapping the volumes to your local host.

### Vault using the container for storage
docker run -d -p 8200:8200 --cap-add=IPC_LOCK --name hckv aeschneider/hcvaultwin

### Vault using volumes on the host for storage
docker run -d -p 8200:8200 --cap-add=IPC_LOCK --name hckv -v c:\vault\logs:c:\vault\logs:rw -v c:\vault\file:c:\vault\file:rw -v c:\vault\config:c:\vault\config:rw aeschneider/hcvaultwin

You need to provide a vault.json yourself in the mapped config folder. The vault.json can be as simple as:

    {
    	"storage": {
    		"file": {
    			"path": "c:\\vault\\file"
    		}
    	},
    	"listener": {
    		"tcp": {
    			"address": "0.0.0.0:8200",
    			"tls_disable": "1"
    		}
    	},
    	"ui": true
    }

## Accessing Vault
Connect with your browser to https://localhost:8200 to access Vault if  TLS is enabled otherwise use http://localhost:8200

