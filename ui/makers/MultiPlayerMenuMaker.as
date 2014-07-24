package makers
{
   import d2actions.*;
   import d2hooks.*;
   import d2network.GameRolePlayMerchantInformations;
   
   public class MultiPlayerMenuMaker extends Object
   {
      
      public function MultiPlayerMenuMaker() {
         super();
      }
      
      public function createMenu(data:*, param:Object) : Array {
         var entity:Object = null;
         var infos:Object = null;
         var subMenu:Object = null;
         var playerEntity:Object = param[0];
         var menu:Array = new Array();
         var cellId:uint = param[0].position.cellId;
         var entities:Object = Api.roleplay.getEntitiesOnCell(cellId);
         var pmm:PlayerMenuMaker = new PlayerMenuMaker();
         var hvmm:HumanVendorMenuMaker = new HumanVendorMenuMaker();
         for each(entity in entities)
         {
            if(entity.id > 0)
            {
               infos = Api.roleplay.getEntityInfos(entity);
               if(infos)
               {
                  if(infos is GameRolePlayMerchantInformations)
                  {
                     subMenu = hvmm.createMenu(infos,[entity]);
                  }
                  else
                  {
                     subMenu = pmm.createMenu(infos,[entity]);
                  }
                  if(!infos.hasOwnProperty("fight"))
                  {
                     menu.push(Api.modMenu.createContextMenuItemObject(infos.name,this.onPutOnTop,[entity],false,subMenu));
                  }
               }
            }
         }
         return menu;
      }
      
      private function onPutOnTop(entity:Object) : void {
         Api.roleplay.putEntityOnTop(entity);
      }
   }
}
