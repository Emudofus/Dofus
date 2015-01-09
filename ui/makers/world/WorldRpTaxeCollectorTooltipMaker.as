package makers.world
{
    import blocks.WorldRpCharacterWithGuildBlock;
    import d2hooks.*;

    public class WorldRpTaxeCollectorTooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/base.txt", "chunks/base/container.txt", "chunks/base/separator.txt");
            var infos:Object = new Object();
            infos.guildName = data.guildIdentity.guildName;
            tooltip.addBlock(new WorldRpCharacterWithGuildBlock(infos).block);
            return (tooltip);
        }


    }
}//package makers.world

