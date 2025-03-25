# Nginx Com Certificado SSL

## 1.0 Descrição

Este projeto consiste em mostrar como é feita a configuração do Nginx com certificados SSL. 

Primeiramente eu gerei um certificado autoassinado com o **OpenSSL**, porém ao acessar o endereço constava um alerta de não seguro. Foi aí que conheci o projeto [mkcert](https://github.com/FiloSottile/mkcert) que gera um certificados SSL válido localmente e é aceito pelo navegador. Com isso o cadeado agora vai ficar igual o Hulk - verde.

## 2.0 Configuração do Nginx

Para fazer a configuração do Nginx eu prefiri utilizado a rede Host, com isso ele compartilha o IP do host e quando alguém acessa o IP do servidor o Nginx trata a requisição.

Para verificar a configuração do servidor acesse o diretório `nginx`. A estrutura dele é:

```
├── conf.d/                       # Diretório com as configurações
├── ssl-certificados              # Diretório que armazena os arquivos .crt e .key
├── execute.sh                    # Script bash que inicia o container Docker do Nginx
```

Para este exemplo não fiz alterações no arquivo **nginx.conf**. No arquivo **default.conf** fiz uma alteração para redirecionar as requisições HTTP para o protocolo HTTPS.

```
server {
    listen 80;
    server_name paulofabiano.com;
    return 301 https://$host$request_uri;
}
```

Com isso todas as requisições que chegam via HTTP são redirecionadas para HTTPS.

## 3.0 Instalando o mkcert

Lembre-se de baixar os pacotes extras que o **mkcert** informa. No meu caso como estou usando um sistema Ubuntu segui esses passos:

- Para instalar o mkcert
```
sudo apt install mkcert
```

- Instalando o libnss3-tools para criar uma Autoridade Certificadora localmente.
```
sudo apt install libnss3-tools
```

- Agora vamos criar e registrar uma Autoridade Certificadora no host e nos navagadores.
```
mkcert -install
```

## 4.0  Gerando Certificado

Para criar o certificado com o **mkcert** é bastante simples, após fazer a instalação dele na sua máquina basta executar o comando:

```
mkcert -key-file key.pem --cert-file cert.pem paulofabiano.com
```

Após executar o comando você verá uma saída semelhante a esta:

```
Created a new certificate valid for the following names 📜
 - "paulofabiano.com"

The certificate is at "cert.pem" and the key at "key.pem" ✅

It will expire on 25 June 2027 🗓
```

Após gerar as chaves **.pem**, basta adicionar ao diretório `ssl-certificados` dentro do diretório `nginx`. 

## 5.0 Acesso

Para simular o acesso a site editei o arquivo `hosts` dentro do diretório `etc`. 

```
127.0.0.1	localhost
127.0.1.1	allSpark
127.0.0.1	paulofabiano.com
```

- Agora quando acessamos pelo navegador podemos ver que não há mais erro de certificado.

![alt text](/images/page.png)

- Como podemos ver o certificado é válido localmente graças ao mkcert.

![alt text](/images/detalhes.png)

## Dúvidas e Sugestões?

Entre em contato comigo via:

- [Linkedin - Paulo Fabiano](https://www.linkedin.com/in/paulo-fabiano/)
- [Email - Paulo Fabiano](pfabianof@gmail.com)

Acesse meus posts no Medium também!

- [Medium - Paulo Fabiano](https://medium.com/@paulofabiano)