package makers
{
   import d2actions.*;
   import d2hooks.*;
   import d2network.MonsterInGroupInformations;
   
   public class MonsterGroupMenuMaker extends Object
   {
      
      public function MonsterGroupMenuMaker() {
         super();
      }
      
      public static var disabled:Boolean = false;
      
      private function askBestiary(monsterIds:Array) : void {
         var data:Object = new Object();
         data.monsterId = 0;
         data.monsterSearch = null;
         data.monsterIdsList = monsterIds;
         data.forceOpen = true;
         Api.system.dispatchHook(OpenBook,"bestiaryTab",data);
      }
      
      public function createMenu(data:*, param:Object) : Array {
         var creature:MonsterInGroupInformations = null;
         var menu:Array = new Array();
         var monsterIds:Array = new Array();
         monsterIds.push(data.staticInfos.mainCreatureLightInfos.creatureGenericId);
         for each(creature in data.staticInfos.underlings)
         {
            if(monsterIds.indexOf(creature.creatureGenericId) == -1)
            {
               monsterIds.push(creature.creatureGenericId);
            }
         }
         Api.system.log(2,"monsterIds " + monsterIds);
         if(monsterIds.length > 0)
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.bestiary"),this.askBestiary,[monsterIds],disabled));
         }
         return menu;
      }
   }
}
