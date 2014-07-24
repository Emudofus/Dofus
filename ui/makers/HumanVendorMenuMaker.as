package makers
{
   import d2actions.*;
   import d2hooks.*;
   
   public class HumanVendorMenuMaker extends Object
   {
      
      public function HumanVendorMenuMaker() {
         super();
      }
      
      public static var disabled:Boolean = false;
      
      private function onMerchantPlayerBuyClick(data:Object) : void {
         Api.system.sendAction(new ExchangeOnHumanVendorRequest(data.contextualId,data.disposition.cellId));
      }
      
      private function onMerchantHouseKickOff(data:Object) : void {
         Api.system.sendAction(new HouseKickIndoorMerchant(data.disposition.cellId));
      }
      
      public function createMenu(data:*, param:Object) : Array {
         var menu:Array = new Array();
         var dead:Boolean = !Api.player.isAlive();
         menu.push(ContextMenu.static_createContextMenuTitleObject(Api.ui.getText("ui.humanVendor.playerShop",data.name,null,disabled)));
         menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.buy"),this.onMerchantPlayerBuyClick,[data],(disabled) || (dead)));
         if(Api.player.isInHisHouse())
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.kickOff"),this.onMerchantHouseKickOff,[data]));
         }
         return menu;
      }
   }
}
