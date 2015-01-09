package makers.world
{
    import blocks.TextTooltipBlock;
    import d2hooks.*;

    public class WorldTaxeCollectorFighterTooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/baseWithBackground.txt", "chunks/base/container.txt", "chunks/base/separator.txt");
            param = {
                "css":"[local.css]tooltip_title.css",
                "classCss":"center"
            };
            if (Api.fight.preFightIsActive())
            {
                tooltip.addBlock(new TextTooltipBlock((((Api.fight.getFighterName(data.contextualId) + " (") + Api.fight.getFighterLevel(data.contextualId)) + ")"), param).block);
            }
            else
            {
                tooltip.addBlock(new TextTooltipBlock((((Api.fight.getFighterName(data.contextualId) + " (") + data.stats.lifePoints) + ")"), param).block);
            };
            return (tooltip);
        }


    }
}//package makers.world

