package makers
{
   import com.ankamagames.dofusModuleLibrary.enum.WebLocationEnum;
   import d2hooks.*;
   import d2actions.*;
   
   public class AccountMenuMaker extends Object
   {
      
      public function AccountMenuMaker() {
         super();
      }
      
      public static var disabled:Boolean = false;
      
      protected function onAnkaboxMessage(accountId:String) : void {
         Api.system.dispatchHook(OpenWebPortal,WebLocationEnum.WEB_LOCATION_ANKABOX_SEND_MESSAGE,false,[accountId]);
      }
      
      public function createMenu(data:*, param:Object) : Array {
         var menu:Array = new Array();
         menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.ankaboxMessage"),this.onAnkaboxMessage,[data.id],disabled));
         return menu;
      }
   }
}
