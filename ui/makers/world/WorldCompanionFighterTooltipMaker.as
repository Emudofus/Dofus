package makers.world
{
    import blocks.MonsterFightBlock;
    import d2hooks.*;

    public class WorldCompanionFighterTooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/baseWithBackground.txt", "chunks/base/container.txt", "chunks/base/separator.txt");
            tooltip.addBlock(new MonsterFightBlock().block);
            return (tooltip);
        }


    }
}//package makers.world

