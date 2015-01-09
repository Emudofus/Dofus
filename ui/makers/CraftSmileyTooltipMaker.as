package makers
{
    import blocks.CraftSmileyTooltipBlock;
    import d2hooks.*;

    public class CraftSmileyTooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/base.txt", "chunks/base/container.txt", "chunks/base/separator.txt");
            tooltip.addBlock(new CraftSmileyTooltipBlock(data).block);
            tooltip.strata = -1;
            return (tooltip);
        }


    }
}//package makers

