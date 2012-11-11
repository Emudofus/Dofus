package com.ankamagames.dofus.network
{

    public class ProtocolConstants extends Object
    {
        public static const MAP_CELL_COUNT:int = 560;
        public static const MAX_LEVEL:int = 200;
        public static const MAX_CHAT_LEN:int = 512;
        public static const USER_MAX_CHAT_LEN:int = 256;
        public static const MIN_LOGIN_LEN:int = 3;
        public static const MAX_LOGIN_LEN:int = 50;
        public static const MIN_PLAYER_NAME_LEN:int = 2;
        public static const MAX_PLAYER_NAME_LEN:int = 20;
        public static const MIN_NICK_LEN:int = 2;
        public static const MAX_NICK_LEN:int = 30;
        public static const MIN_GUILDNAME_LEN:int = 3;
        public static const MAX_GUILDNAME_LEN:int = 30;
        public static const MAX_PLAYER_COLOR:int = 5;
        public static const MAX_ENTITY_COLOR:int = 8;
        public static const MAX_PLAYERS_PER_TEAM:int = 8;
        public static const MAX_MEMBERS_PER_PARTY:int = 8;
        public static const MAX_GUESTS_PER_PARTY:int = 7;
        public static const MAX_MEMBERS_PER_ARENA_PARTY:int = 5;
        public static const MAX_MONSTERS_IN_GROUP_ON_MAP:int = 16;
        public static const MAX_CHAT_OBJECT_REF:int = 16;
        public static const NOT_EQUIPED:int = 63;
        public static const MAX_EQUIPED:int = 255;
        public static const MAX_JOBS_PER_CHARACTER:int = 6;
        public static const MAX_CRAFT_SLOT:int = 9;
        public static const MAX_JOB_LEVEL:int = 100;
        public static const MAX_HONOR:int = 20000;
        public static const MAX_DISHONOR:int = 500;
        public static const MAX_SHORTCUT:int = 99;
        public static const MAX_ARENA_RANK:uint = 2300;
        public static const CHAR_MIN_LEVEL_ARENA:int = 50;
        public static const CHAR_MIN_LEVEL_RIDE:int = 60;

        public function ProtocolConstants()
        {
            return;
        }// end function

    }
}
