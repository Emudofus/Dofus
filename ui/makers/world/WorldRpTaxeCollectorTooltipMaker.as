package makers.world
{
   import d2hooks.*;
   import blocks.WorldRpCharacterWithGuildBlock;
   
   public class WorldRpTaxeCollectorTooltipMaker extends Object
   {
      
      public function WorldRpTaxeCollectorTooltipMaker() {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Object {
         var tooltip:Object = Api.tooltip.createTooltip("chunks/base/base.txt","chunks/base/container.txt","chunks/base/separator.txt");
         var infos:Object = new Object();
         infos.guildName = data.guildIdentity.guildName;
         tooltip.addBlock(new WorldRpCharacterWithGuildBlock(infos).block);
         return tooltip;
      }
   }
}
