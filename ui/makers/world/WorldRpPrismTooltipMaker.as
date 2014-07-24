package makers.world
{
   import blocks.WorldRpPrismBlock;
   import d2hooks.*;
   
   public class WorldRpPrismTooltipMaker extends Object
   {
      
      public function WorldRpPrismTooltipMaker() {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Object {
         var tooltip:Object = Api.tooltip.createTooltip("chunks/base/base.txt","chunks/base/container.txt","chunks/base/empty.txt");
         tooltip.addBlock(new WorldRpPrismBlock(new Object()).block);
         return tooltip;
      }
   }
}
