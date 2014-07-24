package d2network
{
   public class GuildInformations extends BasicGuildInformations
   {
      
      public function GuildInformations() {
         super();
      }
      
      public function get guildEmblem() : GuildEmblem {
         return new GuildEmblem();
      }
   }
}
