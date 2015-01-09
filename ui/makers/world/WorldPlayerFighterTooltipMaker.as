package makers.world
{
    import blocks.CharacterFightBlock;
    import d2hooks.*;

    public class WorldPlayerFighterTooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/base.txt", "chunks/base/container.txt", "chunks/base/empty.txt");
            tooltip.addBlock(new CharacterFightBlock().block);
            return (tooltip);
        }


    }
}//package makers.world

