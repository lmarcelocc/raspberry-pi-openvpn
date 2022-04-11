#!/bin/bash

echo "WITHIN TELEGRAM.sh"

# Telegram Info
telegramBotId = ""
telegramChatId = ""

# You name to appear on telegram bot message
myUser = ""

if [[ $telegramBotId && telegramChatId && myUser ]]; then
    wget https://api.telegram.org/bot$telegramBotId/sendMessage?chat_id=-$telegramChatId"&"text=OPENVPN_WAS_DOWN_TRYING_TO_RESTART_$myUser
fi
