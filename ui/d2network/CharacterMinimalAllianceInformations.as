package d2network
{
    public class CharacterMinimalAllianceInformations extends CharacterMinimalGuildInformations 
    {


        public function get alliance():BasicAllianceInformations
        {
            return (new BasicAllianceInformations());
        }


    }
}//package d2network

