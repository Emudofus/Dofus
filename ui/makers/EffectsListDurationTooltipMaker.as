package makers
{
    import blocks.EffectTooltipBlock;
    import blocks.SeparatorTooltipBlock;
    import d2hooks.*;

    public class EffectsListDurationTooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var bg:String;
            var effectList:Array;
            var e:Object;
            var dataApi:Object = Api.data;
            if (((param) && (param.noBg)))
            {
                bg = "chunks/base/base.txt";
            }
            else
            {
                bg = "chunks/base/baseWithBackground.txt";
            };
            var tooltip:Object = Api.tooltip.createTooltip(bg, "chunks/base/container.txt", "chunks/base/separator.txt");
            var lastTurn:int = -1;
            for each (e in data)
            {
                if (e.duration != lastTurn)
                {
                    if (effectList)
                    {
                        tooltip.addBlock(new EffectTooltipBlock(effectList, 422, true, true, true, false, null, false).block);
                        tooltip.addBlock(new SeparatorTooltipBlock().block);
                    };
                    lastTurn = e.duration;
                    effectList = new Array();
                };
                effectList.push(e);
            };
            tooltip.addBlock(new EffectTooltipBlock(effectList, 422, true, true, true, false, null, false).block);
            tooltip.addBlock(new SeparatorTooltipBlock().block);
            return (tooltip);
        }


    }
}//package makers

