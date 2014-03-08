package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
   import flash.display.Sprite;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerConst;
   
   public class RedrawRegionButton extends Sprite
   {
      
      public function RedrawRegionButton(param1:int, param2:int) {
         super();
         cacheAsBitmap = true;
         x = param1;
         y = param2;
         buttonMode = true;
         graphics.clear();
         graphics.beginFill(16777215,1);
         graphics.lineStyle(2,0);
         graphics.drawRoundRect(0,0,20,FpsManagerConst.BOX_HEIGHT,8,8);
         graphics.endFill();
      }
   }
}
