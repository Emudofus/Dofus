package makers
{
   import blocks.TextInfoTooltipBlock;
   import d2hooks.*;
   
   public class TextInfoTooltipMaker extends Object
   {
      
      public function TextInfoTooltipMaker() {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Object {
         var tooltip:Object = Api.tooltip.createTooltip("chunks/base/simpleBaseWithBackground.txt","chunks/base/container.txt","chunks/base/separator.txt");
         tooltip.addBlock(new TextInfoTooltipBlock().block);
         return tooltip;
      }
   }
}
