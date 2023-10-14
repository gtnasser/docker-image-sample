# imagem origem. neste caso usamos uma imagem oficial do Docker Hub
# que já vem com Node.js e NPM instalados
FROM node:20

# definir a pasta do projeto
WORKDIR /usr/src/app

# instalar as dependências do projeto
COPY package*.json ./
RUN npm install

# If you are building your code for production
# RUN npm ci --omit=dev

# copia o pacote do projeto
COPY . .

# informar as portas utilizadas
EXPOSE 3000

# executar o comando que inicia o servidor
CMD [ "node", "index.js" ]
