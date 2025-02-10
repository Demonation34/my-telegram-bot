# Используем официальный образ Python (например, 3.9-slim)
FROM python:3.9-slim

# Установка системных зависимостей (набор может варьироваться в зависимости от ваших пакетов)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Копирование файла зависимостей
COPY requirements.txt .

# Создание виртуального окружения
RUN python -m venv --copies /opt/venv

# Обновление pip и установка зависимостей с подробным выводом
RUN /opt/venv/bin/pip install --upgrade pip --verbose && \
    /opt/venv/bin/pip install --no-cache-dir -r requirements.txt --verbose

# Копирование исходного кода приложения
COPY . .

# Добавление виртуального окружения в PATH
ENV PATH="/opt/venv/bin:$PATH"

# Команда для запуска приложения
CMD ["python", "app.py"]
