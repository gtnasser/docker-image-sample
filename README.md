# docker-image-sample


## Objetivo

Crir uma imagem docker contendo um servidor em node.js


## Pré-requisitos

[Node.js](https://nodejs.org/en)
[Docker](https://www.docker.com/)
Uma conta no [Docker Hub](https://hub.docker.com/)


## Passos

### 1. Criar um servidor em node.js na porta 3000 que retorna uma mensagem "Olá Mundo Docker"

criar o projeto

```sh
mkdir docker-image-samplenode index
cd docker-image-sample
npm init --yes
```

importar a biblioteca express
```sh
npm install express
```

criar o servidor em index.js:
```js
const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.send('Hello World Docker!')
})

app.listen(port, () => {
  console.log(`Listening on port ${port}`)
})
```

para executá-lo
```sh
node index
```


### 2. Gerar uma imagem Docker dessa aplicação a partir de uma imagem existente de Node.js

criar o arquivo **Dockerfile**, definindo as seguines instruções:
```
# imagem origem. 
# neste caso usamos uma imagem oficial do Docker Hub que já vem com Node.js e NPM instalados
FROM node:20

# definir a pasta do projeto
WORKDIR /usr/src/app

# instalar as dependências do projeto
COPY package*.json ./
RUN npm install

# If you are building your code for production
# RUN npm ci --omit=dev

# copia o pacote do projeto para a pasta WORKDIR
COPY . .

# informar as portas utilizadas
EXPOSE 3000

# executar o comando que inicia o servidor
CMD [ "node", "index.js" ]
```

criar o arquivo .dockerignore na mesma pasta que o arquivo Dockerfile, para prevenir que a pasta node_modules e o log de debug sobreponham os da imagem:
```
node_modules
npm-debug.log
```

Criar a imagem 
```sh
docker build . -t docker-image-sample
```

### 3. Executar a imagem

Para executar a imagem, usamos os flags:
* -d (detached) executa em segundo plano
* -p (ports) mapeia as portas assim: host:imagem
```sh
docker run -p8080:3000 -d docker-image-sample
```

O servidor pode então ser acessado em http://localhost:8080

Para listar as imagens? container?
glag -a para mostrar também os ??
```sh
docker ps -a
```

Quando estiver em execução, podemos executar comandos no container:
```sh
docker exec -it <container_id> /bin/bash
```


### 3. Publicar a imagem no Dockerhub

login com CLI
```sh
docker login
```


Antes de publicar uma imagem no DOcker Hub, é necessário marcá-la com uma Tag única, isso pode ser feito em 2 situações:

Criar uma imagem a partir de um Dockerfile e associar a Tag:

para criar e marcar uma imagem a partir de um Dockerfile:

docker build tag <IMAGE_NAME> <USERNAME>/<NEW_NAME>:<TAG>
```sh
docker build tag docker-image-sample gtnasser/web-server-app:0.0.1
```

Asociar a Tag e uma imagem existente: 

docker tag <IMAGE_NAME> <USERNAME>/<NEW_NAME>:<TAG>
```sh
docker tag docker-image-sample gtnasser/web-server-app:0.0.1
```

para remover Tags de uma imegem:
```sh
docker rmi <REPOSITORY>:<TAG>
```

Publicar a imagem no Dockerhub
```sh
docker push gtnasser/web-server-app:0.0.1
```

Para executar a imagem. Se não existir local, vai baixar do repositório (se públicvo) e executá-la:
```sh
docker run -p 8088:3000 gtnasser/web-server-app
```




