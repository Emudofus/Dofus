package makers
{
    import blocks.TextWithShortcutTooltipBlock;
    import d2hooks.*;

    public class TextWithShortcutTooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/baseWithBackground.txt", "chunks/base/container.txt", "chunks/base/separator.txt");
            tooltip.addBlock(new TextWithShortcutTooltipBlock((data as String), param).block);
            return (tooltip);
        }


    }
}//package makers

