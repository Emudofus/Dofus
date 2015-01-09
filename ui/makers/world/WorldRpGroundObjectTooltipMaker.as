package makers.world
{
    import blocks.TextTooltipBlock;
    import d2hooks.*;

    public class WorldRpGroundObjectTooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/baseWithBackground.txt", "chunks/base/container.txt", "chunks/base/separator.txt");
            tooltip.addBlock(new TextTooltipBlock(data.object.name, {
                "css":"[local.css]tooltip_default.css",
                "classCss":"center"
            }).block);
            return (tooltip);
        }


    }
}//package makers.world

