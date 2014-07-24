package makers.world
{
   import d2hooks.*;
   import blocks.HouseTooltipBlock;
   
   public class WorldRpHouseTooltipMaker extends Object
   {
      
      public function WorldRpHouseTooltipMaker() {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Object {
         var tooltip:Object = Api.tooltip.createTooltip("chunks/base/base.txt","chunks/base/container.txt","chunks/base/empty.txt");
         var infos:Object = new Object();
         infos.ownerName = data.ownerName;
         infos.isOneSale = data.isOnSale;
         infos.isSaleLocked = data.isSaleLocked;
         var guildInfo:Boolean = !(data.guildIdentity == null);
         if(guildInfo)
         {
            infos.guildIdentity = data.guildIdentity;
            tooltip.addBlock(new HouseTooltipBlock(infos,2).block);
         }
         else if(data.isOnSale)
         {
            tooltip.addBlock(new HouseTooltipBlock(infos,1).block);
         }
         else if(data.isSaleLocked)
         {
            tooltip.addBlock(new HouseTooltipBlock(infos,3).block);
         }
         else
         {
            tooltip.addBlock(new HouseTooltipBlock(infos,0).block);
         }
         
         
         return tooltip;
      }
   }
}
