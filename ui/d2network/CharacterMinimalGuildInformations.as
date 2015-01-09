package d2network
{
    public class CharacterMinimalGuildInformations extends CharacterMinimalPlusLookInformations 
    {


        public function get guild():BasicGuildInformations
        {
            return (new BasicGuildInformations());
        }


    }
}//package d2network

