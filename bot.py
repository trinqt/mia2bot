from telegram import Update
from telegram.ext import Updater, CommandHandler, CallbackContext

def start(update: Update, context: CallbackContext) -> None:
    update.message.reply_text("Hello! I am your Mi A2 bot.")

def main():
    updater = Updater("7661043177:AAEL1xO9C1O4vMnr705gZvPPRMh5JN26VHk")

    dispatcher = updater.dispatcher
    dispatcher.add_handler(CommandHandler("start", start))

    updater.start_polling()
    updater.idle()

if __name__ == '__main__':
    main()
