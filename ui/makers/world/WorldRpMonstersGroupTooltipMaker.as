package makers.world
{
    import blocks.WorldRpMonstersAgeBonusBlock;
    import d2hooks.*;

    public class WorldRpMonstersGroupTooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/base.txt", "chunks/base/container.txt", "chunks/base/empty.txt");
            tooltip.addBlock(new WorldRpMonstersAgeBonusBlock().block);
            return (tooltip);
        }


    }
}//package makers.world

