import os
from telegram import Update, InlineKeyboardButton, InlineKeyboardMarkup
from telegram.ext import Updater, CommandHandler, CallbackQueryHandler, CallbackContext
from telegram_bot_calendar import DetailedTelegramCalendar

# Функция для старта
def start(update: Update, context: CallbackContext) -> None:
    keyboard = [
        [InlineKeyboardButton("Календарь", callback_data='calendar')]
    ]
    reply_markup = InlineKeyboardMarkup(keyboard)
    update.message.reply_text('Привет! Нажми на кнопку ниже, чтобы открыть календарь.', reply_markup=reply_markup)

# Функция для отображения календаря
def calendar(update: Update, context: CallbackContext) -> None:
    calendar = DetailedTelegramCalendar(calendar_id=1)
    text = calendar.build()
    update.message.reply_text(text)

# Основная функция для обработки событий
def main() -> None:
    # Получаем токен из переменной окружения
    token = os.getenv("BOT_TOKEN")

    if not token:
        print("BOT_TOKEN не найден в переменных окружения!")
        return

    updater = Updater(token)

    # Получаем диспетчер для обработки команд
    dispatcher = updater.dispatcher

    # Добавляем обработчики команд
    dispatcher.add_handler(CommandHandler("start", start))
    dispatcher.add_handler(CallbackQueryHandler(calendar, pattern='calendar'))

    # Запуск бота
    updater.start_polling()

    # Ожидаем завершения работы
    updater.idle()

if __name__ == '__main__':
    main()
