package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
   import flash.display.Sprite;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerConst;
   
   public class StateButton extends Sprite
   {
      
      public function StateButton(param1:int, param2:int) {
         super();
         x = param1;
         y = param2;
         buttonMode = true;
         cacheAsBitmap = true;
         this._bg = new Shape();
         addChild(this._bg);
         this._triangle = new Shape();
         addChild(this._triangle);
         this.draw(OUT_COLOR,OVER_COLOR);
         addEventListener(MouseEvent.ROLL_OUT,this.rollOutHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.rollOverHandler);
      }
      
      private static const OUT_COLOR:uint = 0;
      
      private static const OVER_COLOR:uint = 16777215;
      
      private var _bg:Shape;
      
      private var _triangle:Shape;
      
      private function rollOutHandler(param1:MouseEvent) : void {
         this.draw(OUT_COLOR,OVER_COLOR);
      }
      
      private function rollOverHandler(param1:MouseEvent) : void {
         this.draw(OVER_COLOR,OUT_COLOR);
      }
      
      public function draw(param1:uint, param2:uint) : void {
         this._bg.graphics.clear();
         this._bg.graphics.beginFill(param1,1);
         this._bg.graphics.lineStyle(2,0);
         this._bg.graphics.drawRoundRect(0,0,20,FpsManagerConst.BOX_HEIGHT,8,8);
         this._bg.graphics.endFill();
         this._triangle.graphics.clear();
         this._triangle.graphics.beginFill(param2,1);
         this._triangle.graphics.drawTriangles(Vector.<Number>([6,20,16,30,6,40]));
         this._triangle.graphics.endFill();
      }
   }
}
