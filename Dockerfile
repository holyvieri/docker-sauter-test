# Estágio 1: Builder
FROM python:3.9-slim AS builder

# Define o diretório de trabalho
WORKDIR /app

# Copia o arquivo requirements.txt para instalar as dependências
COPY requirements.txt .

# Instala as dependências necessárias
RUN pip install --upgrade pip && \
    pip install --user -r requirements.txt

# Copia o código da aplicação
COPY . .

# Estágio 2: Imagem Final
FROM python:3.9-slim

# Define o diretório de trabalho
WORKDIR /app

# Copia apenas os arquivos necessários do estágio builder
COPY --from=builder /app /app
COPY --from=builder /root/.local /root/.local

# Expor a porta que o Flask vai rodar
EXPOSE 8080

# Comando para rodar o app
CMD ["python", "app.py"]
