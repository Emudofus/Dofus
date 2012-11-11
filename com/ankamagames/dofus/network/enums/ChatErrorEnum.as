package com.ankamagames.dofus.network.enums
{

    public class ChatErrorEnum extends Object
    {
        public static const CHAT_ERROR_UNKNOWN:uint = 0;
        public static const CHAT_ERROR_RECEIVER_NOT_FOUND:uint = 1;
        public static const CHAT_ERROR_INTERIOR_MONOLOGUE:uint = 2;
        public static const CHAT_ERROR_NO_GUILD:uint = 3;
        public static const CHAT_ERROR_NO_PARTY:uint = 4;
        public static const CHAT_ERROR_ALIGN:uint = 5;
        public static const CHAT_ERROR_INVALID_MAP:uint = 6;
        public static const CHAT_ERROR_NO_PARTY_ARENA:uint = 7;
        public static const CHAT_ERROR_NO_TEAM:uint = 8;

        public function ChatErrorEnum()
        {
            return;
        }// end function

    }
}
