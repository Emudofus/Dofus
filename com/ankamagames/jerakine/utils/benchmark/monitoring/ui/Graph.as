package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class Graph extends Sprite
    {
        public var indice:String;
        public var points:Vector.<int>;
        public var color:uint;
        private var _isNewFrame:Boolean;
        public var startTime:int = 0;
        private var _menu:Sprite;
        private var _sprTooltip:Sprite;
        private var grapheIsVisible:Boolean = true;
        private static const MENU_OUT_ALPHA:Number = 0.5;

        public function Graph(param1:String, param2:uint = 16777215)
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            this.indice = param1;
            this.color = param2;
            this.points = new Vector.<int>;
            this._isNewFrame = true;
            if (!FpsManagerUtils.isSpecialGraph(this.indice))
            {
                this.grapheIsVisible = false;
                this._menu = new Sprite();
                this._menu.alpha = MENU_OUT_ALPHA;
                this._menu.buttonMode = true;
                this._menu.graphics.beginFill(this.color);
                this._menu.graphics.lineStyle(2, 0);
                this._menu.graphics.drawRect(0, 0, 20, 20);
                this._menu.graphics.endFill();
                this._menu.addEventListener(MouseEvent.CLICK, this.clickHandler);
                this._menu.addEventListener(MouseEvent.ROLL_OVER, this.mouseOverHandler);
                this._menu.addEventListener(MouseEvent.ROLL_OUT, this.mouseOutHandler);
                addChild(this._menu);
                _loc_3 = new TextFormat("Verdana", 13);
                _loc_3.color = this.color;
                _loc_4 = new TextField();
                _loc_4.mouseEnabled = false;
                _loc_4.selectable = false;
                _loc_4.defaultTextFormat = _loc_3;
                _loc_4.text = this.indice;
                _loc_4.x = (_loc_4.width - _loc_4.textWidth) / 2;
                this._sprTooltip = new Sprite();
                this._sprTooltip.graphics.beginFill(16777215);
                this._sprTooltip.graphics.lineStyle(1, 0);
                this._sprTooltip.graphics.drawRoundRect(0, 0, _loc_4.width, 20, 4, 4);
                this._sprTooltip.addChild(_loc_4);
                this._sprTooltip.y = -30;
                this._sprTooltip.x = -10;
            }
            return;
        }// end function

        private function clickHandler(event:MouseEvent) : void
        {
            this.grapheIsVisible = !this.grapheIsVisible;
            this._menu.alpha = this.grapheIsVisible ? (1) : (MENU_OUT_ALPHA);
            if (this.grapheIsVisible)
            {
                dispatchEvent(new Event("showGraph"));
            }
            else
            {
                dispatchEvent(new Event("hideGraph"));
            }
            return;
        }// end function

        private function mouseOverHandler(event:MouseEvent) : void
        {
            if (!this.grapheIsVisible)
            {
                this._menu.alpha = 1;
            }
            this._menu.addChild(this._sprTooltip);
            return;
        }// end function

        private function mouseOutHandler(event:MouseEvent) : void
        {
            if (!this.grapheIsVisible)
            {
                this._menu.alpha = MENU_OUT_ALPHA;
            }
            this._menu.removeChild(this._sprTooltip);
            return;
        }// end function

        public function insertNewValue(param1:int) : void
        {
            if (this._isNewFrame)
            {
                this.addValue(param1);
            }
            else
            {
                this.updateLastValue(param1);
            }
            return;
        }// end function

        private function addValue(param1:int) : void
        {
            this._isNewFrame = false;
            this.points.push(param1);
            return;
        }// end function

        private function updateLastValue(param1:int) : void
        {
            this.points[(this.points.length - 1)] = this.points[(this.points.length - 1)] + param1;
            return;
        }// end function

        public function setNewFrame() : void
        {
            if (!FpsManagerUtils.isSpecialGraph(this.indice))
            {
                this.startTime = 0;
            }
            this._isNewFrame = true;
            return;
        }// end function

        public function get length() : int
        {
            return this.points.length;
        }// end function

        public function setMenuPosition(param1:Number, param2:Number) : void
        {
            this._menu.x = param1;
            this._menu.y = param2;
            return;
        }// end function

        public function get graphVisible() : Boolean
        {
            return this.grapheIsVisible;
        }// end function

    }
}
