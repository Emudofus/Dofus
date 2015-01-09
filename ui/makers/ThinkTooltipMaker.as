package makers
{
    import blocks.ThinkTooltipBlock;
    import d2hooks.*;

    public class ThinkTooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/base.txt", "chunks/base/container.txt", "chunks/base/separator.txt");
            tooltip.addBlock(new ThinkTooltipBlock((data.text as String)).block);
            tooltip.strata = -1;
            return (tooltip);
        }


    }
}//package makers

