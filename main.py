# © @dothanh1110 # Tôn trọng thì đừng xoá

import os
import shutil
import subprocess
import telebot

TOKEN = '7379104019:AAGCptqj2KVzQc6sDD0C-PaTnkBxVm_scuQ'
bot = telebot.TeleBot(TOKEN)
M_FILE_PATH = '/mnt/e/prjtheos/fps/fpsrainbow/fpsrainbow/FPSDisplay.m'
BACKUP_FILE_PATH = '/mnt/e/prjtheos/fps/fpsrainbow/fpsrainbow/FPSDisplay_backup.m'

@bot.message_handler(commands=['start'])
def send_welcome(message):
    bot.reply_to(message, "👋 Xin chào! Bot này cho phép bạn tùy chỉnh và build dự án Theos.\n\n"
                          "⚙️ Sử dụng lệnh /fps {tên_fps} để thay đổi tên FPS và bắt đầu quá trình build.")

@bot.message_handler(commands=['fps'])
def handle_fps(message):
    try:
        args = message.text.split(' ')
        if len(args) != 2:
            bot.reply_to(message, "⚠️ Vui lòng cung cấp tên FPS. Sử dụng: /fps {fps_name}")
            return

        fps_name = args[1]
        backup_m_file()
        modify_m_file(fps_name)
        msg = bot.reply_to(message, "🔧 Đang bắt đầu quá trình make...")
        run_make_commands(msg)
        send_dylib_file(message, msg, fps_name)
        restore_m_file()

    except Exception as e:
        bot.reply_to(message, f"❌ Có lỗi xảy ra: {e}")

def backup_m_file():
    shutil.copy(M_FILE_PATH, BACKUP_FILE_PATH)

def restore_m_file():
    shutil.copy(BACKUP_FILE_PATH, M_FILE_PATH)

def modify_m_file(fps_name):
    with open(M_FILE_PATH, 'r') as file:
        content = file.read()
    new_content = content.replace(
        '@" %d FPS | %@ | Pin: %0.0f  Hello World "', 
        f'@" %d FPS | %@ | Pin: %0.0f  {fps_name}"'
    )
    with open(M_FILE_PATH, 'w') as file:
        file.write(new_content)

def run_make_commands(msg):
    subprocess.run(['make', 'clean'], cwd=os.path.dirname(M_FILE_PATH), text=True, capture_output=True)
    make_process = subprocess.Popen(['make'], cwd=os.path.dirname(M_FILE_PATH), text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    steps = 10  
    current_step = 0

    while True:
        output = make_process.stdout.readline()
        if output == '' and make_process.poll() is not None:
            break
        if output:
            current_step += 1
            progress = int((current_step / steps) * 90)
            bot.edit_message_text(f"🔧 Đang bắt đầu quá trình make... {progress}% hoàn thành", chat_id=msg.chat.id, message_id=msg.message_id)
    make_process.communicate()

def send_dylib_file(message, msg, fps_name):
    dylib_path = os.path.join(os.path.dirname(M_FILE_PATH), '.theos', 'obj', 'debug', 'BoniOS.dylib')
    
    with open(dylib_path, 'rb') as dylib_file:
        bot.send_document(message.chat.id, dylib_file, caption=f"📂 File `.dylib` đã được tạo thành công với tên FPS: *{fps_name}*.", parse_mode="Markdown")
        bot.edit_message_text(f"🔧 Quá trình make đã hoàn thành 100%. File đã được gửi!", chat_id=msg.chat.id, message_id=msg.message_id)

bot.polling()
