package makers
{
   import blocks.TextureTooltipBlock;
   import d2hooks.*;
   
   public class TexturesListTooltipMaker extends Object
   {
      
      public function TexturesListTooltipMaker() {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Object {
         var uri:* = undefined;
         var bg:String = "chunks/base/base.txt";
         var tooltip:Object = Api.tooltip.createTooltip(bg,"chunks/base/linearContainer.txt");
         var texturesList:Object = data;
         for each(uri in texturesList)
         {
            tooltip.addBlock(new TextureTooltipBlock(uri).block);
         }
         tooltip.strata = -1;
         return tooltip;
      }
   }
}
