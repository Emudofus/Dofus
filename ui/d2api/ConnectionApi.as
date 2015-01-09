package d2api
{
    import d2network.GameServerInformations;

    public class ConnectionApi 
    {


        [Untrusted]
        public function getUsedServers():Object
        {
            return (null);
        }

        [Untrusted]
        public function getServers():Object
        {
            return (null);
        }

        [Untrusted]
        public function hasGuestAccount():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isCharacterWaitingForChange(id:int):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function allowAutoConnectCharacter(allow:Boolean):void
        {
        }

        [Untrusted]
        public function getAutochosenServer():GameServerInformations
        {
            return (null);
        }


    }
}//package d2api

