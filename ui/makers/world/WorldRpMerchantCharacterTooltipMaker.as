package makers.world
{
   import blocks.WorldRpCharacterBlock;
   import d2hooks.*;
   
   public class WorldRpMerchantCharacterTooltipMaker extends Object
   {
      
      public function WorldRpMerchantCharacterTooltipMaker() {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Object {
         var tooltip:Object = Api.tooltip.createTooltip("chunks/base/base.txt","chunks/base/container.txt","chunks/base/empty.txt");
         tooltip.addBlock(new WorldRpCharacterBlock().block);
         return tooltip;
      }
   }
}
