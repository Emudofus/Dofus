package makers
{
   import d2actions.*;
   import d2hooks.*;
   
   public class NpcMenuMaker extends Object
   {
      
      public function NpcMenuMaker() {
         super();
      }
      
      public static var disabled:Boolean = false;
      
      private function onNPCMenuClick(pNPCId:int, pActionId:int) : void {
         Api.system.sendAction(new NpcGenericActionRequest(pNPCId,pActionId));
      }
      
      public function createMenu(data:*, param:Object) : Array {
         var action:uint = 0;
         var actionData:Object = null;
         var menu:Array = new Array();
         var dead:Boolean = !Api.player.isAlive();
         var npcId:int = data.npcId;
         var npc:Object = Api.data.getNpc(npcId);
         var npcActions:Object = npc.actions;
         if(npcActions.length > 0)
         {
            menu.push(ContextMenu.static_createContextMenuTitleObject(npc.name));
            for each(action in npcActions)
            {
               actionData = Api.data.getNpcAction(action);
               menu.push(ContextMenu.static_createContextMenuItemObject(actionData.name,this.onNPCMenuClick,[param[0].id,action],(disabled) || (dead)));
            }
         }
         return menu;
      }
   }
}
