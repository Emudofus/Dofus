package d2api
{
   import d2network.GameServerInformations;
   
   public class ConnectionApi extends Object
   {
      
      public function ConnectionApi() {
         super();
      }
      
      public function getUsedServers() : Object {
         return null;
      }
      
      public function getServers() : Object {
         return null;
      }
      
      public function isCharacterWaitingForChange(id:int) : Boolean {
         return false;
      }
      
      public function allowAutoConnectCharacter(allow:Boolean) : void {
      }
      
      public function getAutochosenServer() : GameServerInformations {
         return null;
      }
   }
}
