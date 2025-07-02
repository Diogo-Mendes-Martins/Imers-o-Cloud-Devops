# Use uma imagem oficial do Python como imagem base.
# As imagens Alpine são leves, o que é ótimo para produção.
FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho no contêiner
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho
COPY requirements.txt .

# Instala os pacotes necessários especificados em requirements.txt
# --no-cache-dir reduz o tamanho da imagem
# --upgrade pip garante que temos a versão mais recente
RUN pip install --no-cache-dir --upgrade pip -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Torna a porta 8000 disponível para o mundo fora deste contêiner
EXPOSE 8000

# Executa app.py quando o contêiner for iniciado
# Use 0.0.0.0 para tornar a aplicação acessível de fora do contêiner
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]