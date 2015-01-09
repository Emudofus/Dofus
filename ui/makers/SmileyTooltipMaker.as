package makers
{
    import blocks.SmileyTooltipBlock;
    import d2hooks.*;

    public class SmileyTooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/base.txt", "chunks/base/container.txt", "chunks/base/separator.txt");
            tooltip.addBlock(new SmileyTooltipBlock(data.id).block);
            tooltip.strata = -1;
            return (tooltip);
        }


    }
}//package makers

