# Используем официальный образ Python
FROM python:3.9-slim

# Установка системных зависимостей (если нужно)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Установка рабочей директории
WORKDIR /app

# Копирование файла зависимостей
COPY requirements.txt .

# Создание виртуального окружения
RUN python -m venv --copies /opt/venv

# Обновление pip и установка зависимостей через абсолютный путь
RUN /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install --no-cache-dir -r requirements.txt

# Копирование исходного кода приложения
COPY . .

# Добавление виртуального окружения в PATH
ENV PATH="/opt/venv/bin:$PATH"

# Команда для запуска приложения
CMD ["python", "app.py"]
