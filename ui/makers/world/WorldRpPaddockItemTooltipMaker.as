package makers.world
{
    import blocks.mount.PaddockItemBlock;
    import d2hooks.*;

    public class WorldRpPaddockItemTooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/base.txt", "chunks/base/container.txt", "chunks/base/separator.txt");
            tooltip.addBlock(new PaddockItemBlock(data).block);
            return (tooltip);
        }


    }
}//package makers.world

