package makers.world
{
   import blocks.CharacterFightBlock;
   import d2hooks.*;
   
   public class WorldPlayerFighterTooltipMaker extends Object
   {
      
      public function WorldPlayerFighterTooltipMaker() {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Object {
         var tooltip:Object = Api.tooltip.createTooltip("chunks/base/base.txt","chunks/base/container.txt","chunks/base/empty.txt");
         tooltip.addBlock(new CharacterFightBlock().block);
         return tooltip;
      }
   }
}
