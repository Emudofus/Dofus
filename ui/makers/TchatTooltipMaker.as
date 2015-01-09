package makers
{
    import blocks.TchatTooltipBlock;
    import d2hooks.*;

    public class TchatTooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/base.txt", "chunks/base/container.txt", "chunks/base/separator.txt");
            tooltip.addBlock(new TchatTooltipBlock((data.text as String)).block);
            tooltip.strata = -1;
            return (tooltip);
        }


    }
}//package makers

