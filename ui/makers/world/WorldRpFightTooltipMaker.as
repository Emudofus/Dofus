package makers.world
{
    import blocks.FightTooltipBlock;
    import d2hooks.*;

    public class WorldRpFightTooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var totalLevel:uint;
            var fighter:*;
            var teamMembers:* = data.fighters;
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/baseWithBackground.txt", "chunks/base/container.txt", "chunks/base/empty.txt");
            var infos:Object = new Object();
            var textList:String = "";
            for each (fighter in teamMembers)
            {
                totalLevel = (totalLevel + fighter.level);
            };
            infos.level = ((Api.ui.getText("ui.common.level") + " ") + totalLevel);
            tooltip.addBlock(new FightTooltipBlock(infos).block);
            return (tooltip);
        }


    }
}//package makers.world

