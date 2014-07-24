package d2network
{
   public class HumanOptionGuild extends HumanOption
   {
      
      public function HumanOptionGuild() {
         super();
      }
      
      public function get guildInformations() : GuildInformations {
         return new GuildInformations();
      }
   }
}
