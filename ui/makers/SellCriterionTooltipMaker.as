package makers
{
    import blocks.ConditionTooltipBlock;

    public class SellCriterionTooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var bg:String = "chunks/base/baseWithBackground.txt";
            var tooltip:Object = Api.tooltip.createTooltip(bg, "chunks/base/container.txt", "chunks/base/separator.txt");
            tooltip.addBlock(new ConditionTooltipBlock({"criteria":[data]}, 422, data, Api.ui.getText("ui.sell.condition")).block);
            return (tooltip);
        }


    }
}//package makers

