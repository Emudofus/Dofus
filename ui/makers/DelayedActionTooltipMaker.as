package makers
{
   import blocks.DelayedActionTooltipBlock;
   
   public class DelayedActionTooltipMaker extends Object
   {
      
      public function DelayedActionTooltipMaker() {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Object {
         var tooltip:Object = Api.tooltip.createTooltip("chunks/base/base.txt","chunks/base/container.txt","chunks/base/separator.txt");
         tooltip.addBlock(new DelayedActionTooltipBlock(data).block);
         tooltip.strata = -1;
         return tooltip;
      }
   }
}
