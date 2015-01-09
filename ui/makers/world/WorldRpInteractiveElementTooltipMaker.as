package makers.world
{
    import blocks.InteractiveElementBlock;

    public class WorldRpInteractiveElementTooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/base.txt", "chunks/base/container.txt", "chunks/base/empty.txt");
            tooltip.addBlock(new InteractiveElementBlock(data).block);
            return (tooltip);
        }


    }
}//package makers.world

