# Используем официальный образ Python
FROM python:3.9-slim

# Установка системных зависимостей (при необходимости)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    libxml2-dev \
    libxslt1-dev \
    && rm -rf /var/lib/apt/lists/*

# Установка рабочей директории
WORKDIR /app

# Копирование файла зависимостей
COPY requirements.txt .

# Создание виртуального окружения
RUN python -m venv --copies /opt/venv

# Обновление pip и установка зависимостей
RUN . /opt/venv/bin/activate && pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Копирование исходного кода приложения
COPY . .

# Указание переменной окружения для использования виртуального окружения
ENV PATH="/opt/venv/bin:$PATH"

# Команда для запуска приложения
CMD ["python", "app.py"]
