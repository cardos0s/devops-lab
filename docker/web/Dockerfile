# Imagem do frontend: nginx servindo o HTML estático + proxy para a API.
FROM nginx:1.27-alpine

# Remove a config default e usa a nossa
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/app.conf
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80
# nginx:alpine já tem o CMD correto; não precisa redefinir.
