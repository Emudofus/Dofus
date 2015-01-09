package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
    import flash.display.Sprite;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerConst;

    public class RedrawRegionButton extends Sprite 
    {

        public function RedrawRegionButton(pX:int, pY:int)
        {
            cacheAsBitmap = true;
            x = pX;
            y = pY;
            buttonMode = true;
            graphics.clear();
            graphics.beginFill(0xFFFFFF, 1);
            graphics.lineStyle(2, 0);
            graphics.drawRoundRect(0, 0, 20, FpsManagerConst.BOX_HEIGHT, 8, 8);
            graphics.endFill();
        }

    }
}//package com.ankamagames.jerakine.utils.benchmark.monitoring.ui

