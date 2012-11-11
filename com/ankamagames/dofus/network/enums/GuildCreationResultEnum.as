package com.ankamagames.dofus.network.enums
{

    public class GuildCreationResultEnum extends Object
    {
        public static const GUILD_CREATE_OK:uint = 1;
        public static const GUILD_CREATE_ERROR_NAME_INVALID:uint = 2;
        public static const GUILD_CREATE_ERROR_ALREADY_IN_GUILD:uint = 3;
        public static const GUILD_CREATE_ERROR_NAME_ALREADY_EXISTS:uint = 4;
        public static const GUILD_CREATE_ERROR_EMBLEM_ALREADY_EXISTS:uint = 5;
        public static const GUILD_CREATE_ERROR_LEAVE:uint = 6;
        public static const GUILD_CREATE_ERROR_CANCEL:uint = 7;
        public static const GUILD_CREATE_ERROR_REQUIREMENT_UNMET:uint = 8;
        public static const GUILD_CREATE_ERROR_EMBLEM_INVALID:uint = 9;

        public function GuildCreationResultEnum()
        {
            return;
        }// end function

    }
}
