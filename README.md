# Theos Build Bot

## Giới thiệu

Chào mừng bạn đến với **Theos Build Bot**! Bot này cho phép bạn tùy chỉnh và xây dựng dự án Theos một cách dễ dàng ngay từ Telegram. Chỉ cần sử dụng lệnh `/fps {tên_fps}`, bot sẽ thay đổi tên FPS trong file `.m`, thực hiện quá trình build, và gửi file `.dylib` đã được tạo thành công về cho bạn.

## Cài đặt và yêu cầu

### Yêu cầu

1. **Python 3.x**: Đảm bảo rằng bạn đã cài đặt Python 3 trên hệ thống của mình. Bạn có thể tải Python từ [trang chính thức của Python](https://www.python.org/downloads/).

2. **Thư viện Python**:
   - `pyTelegramBotAPI` (thư viện `telebot`): Để cài đặt, bạn có thể sử dụng pip:
     ```bash
     pip install pyTelegramBotAPI
     ```

3. **Theos**: Để bot hoạt động chính xác, bạn cần phải có Theos được cài đặt trên hệ thống của mình. Bạn có thể tham khảo hướng dẫn cài đặt Theos [tại đây](https://theos.dev).

4. **Công cụ xây dựng (build tools)**: Đảm bảo rằng bạn có công cụ xây dựng cần thiết như `make` và các công cụ khác để thực hiện build dự án Theos.

### Cấu hình

1. **Thay đổi mã nguồn**:
   - Mở file mã nguồn của bot và thay đổi giá trị của biến `TOKEN` với token của bạn từ BotFather.
   - Cập nhật đường dẫn `M_FILE_PATH` và `BACKUP_FILE_PATH` để trỏ đến đường dẫn đúng trên hệ thống của bạn.

2. **Tạo một bot Telegram**:
   - Truy cập [BotFather](https://t.me/botfather) trên Telegram và tạo một bot mới.
   - Lưu lại token của bot và cập nhật vào biến `TOKEN` trong mã nguồn của bot.

### Chạy bot

1. **Cài đặt các phụ thuộc**:
   - Đảm bảo rằng bạn đã cài đặt tất cả các thư viện cần thiết bằng lệnh pip đã đề cập ở trên.

2. **Chạy bot**:
   - Mở terminal hoặc command prompt và điều hướng đến thư mục chứa file mã nguồn của bot.
   - Chạy lệnh sau để khởi động bot:
     ```bash
     python3 <tên_file_mãnguồn>.py
     ```

   Ví dụ, nếu file mã nguồn của bạn là `main.py`, chạy:
   ```bash
   python3 main.py

## Preview

|                                            DEMO                                            |                                            Login success                                            |
| :-----------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------: |
| ![](https://raw.githubusercontent.com/thanhdo1110/bot_make_fps_theos/main/ctdotech_demo.jpg) | ![](https://raw.githubss.png) |



