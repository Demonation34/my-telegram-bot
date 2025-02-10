import logging
from aiogram import Bot, Dispatcher, types
from aiogram.types import InlineKeyboardButton, InlineKeyboardMarkup
from aiogram.utils import executor
import calendar

API_TOKEN = '8074120036:AAEhkClYTLdGtTdj5xCN9Qufv9WpLb0nCiY'  # замените на реальный токен из BotFather

logging.basicConfig(level=logging.INFO)

bot = Bot(token=API_TOKEN)
dp = Dispatcher(bot)

# Обработчик команды /start
@dp.message_handler(commands=['start'])
async def send_welcome(message: types.Message):
    markup = InlineKeyboardMarkup()
    calendar_button = InlineKeyboardButton("Календарь", callback_data="calendar")
    markup.add(calendar_button)
    await message.answer("Привет! Нажми на кнопку для получения календаря.", reply_markup=markup)

# Обработчик нажатия на кнопку "Календарь"
@dp.callback_query_handler(lambda c: c.data == 'calendar')
async def show_calendar(callback_query: types.CallbackQuery):
    year = 2025
    month = 2
    cal = calendar.month(year, month)
    await bot.send_message(callback_query.from_user.id, f"Вот календарь на {calendar.month_name[month]} {year}:\n\n{cal}")

if __name__ == '__main__':
    executor.start_polling(dp, skip_updates=True)
