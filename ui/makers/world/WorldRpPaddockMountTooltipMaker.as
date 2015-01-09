package makers.world
{
    import blocks.TextTooltipBlock;
    import d2hooks.*;

    public class WorldRpPaddockMountTooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/baseWithBackground.txt", "chunks/base/container.txt", "chunks/base/separator.txt");
            var text:String = data.name;
            if (data.name == "")
            {
                text = Api.ui.getText("ui.common.noName");
            }
            else
            {
                text = data.name;
            };
            if (Api.player.getPlayedCharacterInfo().name != data.ownerName)
            {
                text = (text + ("\n" + Api.ui.getText("ui.mount.mountOf", data.ownerName)));
            };
            text = (text + ((("\n" + Api.ui.getText("ui.common.level")) + " ") + data.level));
            tooltip.addBlock(new TextTooltipBlock(text, {
                "css":"[local.css]tooltip_title.css",
                "classCss":"center"
            }).block);
            return (tooltip);
        }


    }
}//package makers.world

