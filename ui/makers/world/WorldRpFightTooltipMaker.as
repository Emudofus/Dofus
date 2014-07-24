package makers.world
{
   import d2hooks.*;
   import blocks.FightTooltipBlock;
   
   public class WorldRpFightTooltipMaker extends Object
   {
      
      public function WorldRpFightTooltipMaker() {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Object {
         var totalLevel:uint = 0;
         var fighter:* = undefined;
         var teamMembers:* = data.fighters;
         var tooltip:Object = Api.tooltip.createTooltip("chunks/base/baseWithBackground.txt","chunks/base/container.txt","chunks/base/empty.txt");
         var infos:Object = new Object();
         var textList:String = "";
         for each(fighter in teamMembers)
         {
            totalLevel = totalLevel + fighter.level;
         }
         infos.level = Api.ui.getText("ui.common.level") + " " + totalLevel;
         tooltip.addBlock(new FightTooltipBlock(infos).block);
         return tooltip;
      }
   }
}
