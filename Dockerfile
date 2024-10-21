# Stage 1: Build
FROM python:3.9-slim as builder

WORKDIR /app

# Instalar dependências
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Copiar o código da aplicação
COPY app.py .

# Stage 2: Final
FROM python:3.9-slim

WORKDIR /app

# Copiar dependências e código da Stage 1
COPY --from=builder /root/.local /root/.local
COPY --from=builder /app /app

# Definir variáveis de ambiente
ENV PATH=/root/.local/bin:$PATH

# Expor a porta e rodar o app
EXPOSE 8080
CMD ["python", "app.py"]
