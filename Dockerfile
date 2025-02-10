FROM python:3.9-slim

# Обновление списка пакетов и установка необходимых системных зависимостей
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    # Если нужны дополнительные библиотеки, например, для lxml или других пакетов:
    libxml2-dev \
    libxslt1-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

RUN python -m venv --copies /opt/venv

# Обновляем pip и устанавливаем зависимости с подробным логом
RUN /opt/venv/bin/pip install --upgrade pip --verbose && \
    /opt/venv/bin/pip install --no-cache-dir -r requirements.txt --verbose

COPY . .

ENV PATH="/opt/venv/bin:$PATH"

CMD ["python", "app.py"]
