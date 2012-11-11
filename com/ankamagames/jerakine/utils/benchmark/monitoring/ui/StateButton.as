package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
    import com.ankamagames.jerakine.utils.benchmark.monitoring.*;
    import flash.display.*;
    import flash.events.*;

    public class StateButton extends Sprite
    {
        private var _bg:Shape;
        private var _triangle:Shape;
        private static const OUT_COLOR:uint = 0;
        private static const OVER_COLOR:uint = 16777215;

        public function StateButton(param1:int, param2:int)
        {
            x = param1;
            y = param2;
            buttonMode = true;
            cacheAsBitmap = true;
            this._bg = new Shape();
            addChild(this._bg);
            this._triangle = new Shape();
            addChild(this._triangle);
            this.draw(OUT_COLOR, OVER_COLOR);
            addEventListener(MouseEvent.ROLL_OUT, this.rollOutHandler);
            addEventListener(MouseEvent.ROLL_OVER, this.rollOverHandler);
            return;
        }// end function

        private function rollOutHandler(event:MouseEvent) : void
        {
            this.draw(OUT_COLOR, OVER_COLOR);
            return;
        }// end function

        private function rollOverHandler(event:MouseEvent) : void
        {
            this.draw(OVER_COLOR, OUT_COLOR);
            return;
        }// end function

        public function draw(param1:uint, param2:uint) : void
        {
            this._bg.graphics.clear();
            this._bg.graphics.beginFill(param1, 1);
            this._bg.graphics.lineStyle(2, 0);
            this._bg.graphics.drawRoundRect(0, 0, 20, FpsManagerConst.BOX_HEIGHT, 8, 8);
            this._bg.graphics.endFill();
            this._triangle.graphics.clear();
            this._triangle.graphics.beginFill(param2, 1);
            this._triangle.graphics.drawTriangles(this.Vector.<Number>([6, 20, 16, 30, 6, 40]));
            this._triangle.graphics.endFill();
            return;
        }// end function

    }
}
