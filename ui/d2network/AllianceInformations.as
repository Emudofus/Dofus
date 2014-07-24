package d2network
{
   public class AllianceInformations extends BasicNamedAllianceInformations
   {
      
      public function AllianceInformations() {
         super();
      }
      
      public function get allianceEmblem() : GuildEmblem {
         return new GuildEmblem();
      }
   }
}
