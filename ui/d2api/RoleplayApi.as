package d2api
{
   public class RoleplayApi extends Object
   {
      
      public function RoleplayApi() {
         super();
      }
      
      public function destroy() : void {
      }
      
      public function getTotalFightOnCurrentMap() : uint {
         return 0;
      }
      
      public function getSpellToForgetList() : Object {
         return null;
      }
      
      public function getEmotesList() : Object {
         return null;
      }
      
      public function getUsableEmotesList() : Object {
         return null;
      }
      
      public function getSpawnMap() : uint {
         return 0;
      }
      
      public function getEntitiesOnCell(cellId:int) : Object {
         return null;
      }
      
      public function getPlayersIdOnCurrentMap() : Object {
         return null;
      }
      
      public function getPlayerIsInCurrentMap(playerId:int) : Boolean {
         return false;
      }
      
      public function isUsingInteractive() : Boolean {
         return false;
      }
      
      public function getFight(id:int) : Object {
         return null;
      }
      
      public function putEntityOnTop(entity:Object) : void {
      }
      
      public function getEntityInfos(entity:Object) : Object {
         return null;
      }
      
      public function getEntityByName(name:String) : Object {
         return null;
      }
      
      public function switchButtonWrappers(btnWrapper1:Object, btnWrapper2:Object) : void {
      }
      
      public function setButtonWrapperActivation(btnWrapper:Object, active:Boolean) : void {
      }
   }
}
