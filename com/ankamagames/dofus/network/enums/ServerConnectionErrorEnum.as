package com.ankamagames.dofus.network.enums
{

    public class ServerConnectionErrorEnum extends Object
    {
        public static const SERVER_CONNECTION_ERROR_DUE_TO_STATUS:uint = 0;
        public static const SERVER_CONNECTION_ERROR_NO_REASON:uint = 1;
        public static const SERVER_CONNECTION_ERROR_ACCOUNT_RESTRICTED:uint = 2;
        public static const SERVER_CONNECTION_ERROR_COMMUNITY_RESTRICTED:uint = 3;
        public static const SERVER_CONNECTION_ERROR_LOCATION_RESTRICTED:uint = 4;
        public static const SERVER_CONNECTION_ERROR_SUBSCRIBERS_ONLY:uint = 5;
        public static const SERVER_CONNECTION_ERROR_REGULAR_PLAYERS_ONLY:uint = 6;

        public function ServerConnectionErrorEnum()
        {
            return;
        }// end function

    }
}
