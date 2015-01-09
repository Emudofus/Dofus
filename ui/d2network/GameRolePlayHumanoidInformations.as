package d2network
{
    public class GameRolePlayHumanoidInformations extends GameRolePlayNamedActorInformations 
    {


        public function get humanoidInfo():HumanInformations
        {
            return (new HumanInformations());
        }

        public function get accountId():uint
        {
            return (new uint());
        }


    }
}//package d2network

