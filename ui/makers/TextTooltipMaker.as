package makers
{
    import blocks.TextTooltipBlock;
    import d2hooks.*;

    public class TextTooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/baseWithBackground.txt", "chunks/base/container.txt", "chunks/base/separator.txt");
            tooltip.addBlock(new TextTooltipBlock((data as String), param).block);
            return (tooltip);
        }


    }
}//package makers

