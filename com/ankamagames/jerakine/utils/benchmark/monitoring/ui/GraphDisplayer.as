package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;

    public class GraphDisplayer extends Sprite
    {
        private var _txtSprite:Sprite;
        private var _fpsTf:TextField;
        private var _memTf:TextField;
        public var previousFreeMem:Number;
        private var _graphSpr:Sprite;
        private var _graphDisplay:Bitmap;
        private var _graphToDisplay:Dictionary;
        private var _redrawRegionsVisible:Boolean = false;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(GraphDisplayer));

        public function GraphDisplayer()
        {
            this._graphToDisplay = new Dictionary();
            this.initDisplay();
            this.initTexts();
            return;
        }// end function

        private function initTexts() : void
        {
            var _loc_1:TextFormat = null;
            this._txtSprite = new Sprite();
            this._txtSprite.mouseEnabled = false;
            this._txtSprite.x = FpsManagerConst.PADDING_LEFT;
            this._txtSprite.y = FpsManagerConst.PADDING_TOP;
            _loc_1 = new TextFormat("Verdana", 13);
            _loc_1.color = 16777215;
            this._fpsTf = new TextField();
            this._fpsTf.defaultTextFormat = _loc_1;
            this._fpsTf.selectable = false;
            this._fpsTf.text = StageShareManager.stage.frameRate + " FPS";
            this._txtSprite.addChild(this._fpsTf);
            this._memTf = new TextField();
            this._memTf.y = 30;
            this._memTf.defaultTextFormat = _loc_1;
            this._memTf.selectable = false;
            this._memTf.text = "00 MB";
            this._txtSprite.addChild(this._memTf);
            addChild(this._txtSprite);
            return;
        }// end function

        private function initDisplay() : void
        {
            graphics.beginFill(FpsManagerConst.BOX_COLOR, 0.7);
            graphics.lineStyle(FpsManagerConst.BOX_BORDER, 0);
            graphics.drawRoundRect(0, 0, FpsManagerConst.BOX_WIDTH, FpsManagerConst.BOX_HEIGHT, 8, 8);
            graphics.endFill();
            this._graphSpr = new Sprite();
            addChild(this._graphSpr);
            this._graphDisplay = new Bitmap(new BitmapData(FpsManagerConst.BOX_WIDTH, FpsManagerConst.BOX_HEIGHT, true, 0));
            this._graphDisplay.smoothing = true;
            addChild(this._graphDisplay);
            var _loc_1:* = new Sprite();
            _loc_1.graphics.beginFill(0, 0.4);
            _loc_1.graphics.drawRoundRect(0, 0, FpsManagerConst.BOX_FILTER_WIDTH, FpsManagerConst.BOX_HEIGHT, 8, 8);
            addChild(_loc_1);
            return;
        }// end function

        public function update() : void
        {
            var _loc_2:int = 0;
            var _loc_3:uint = 0;
            var _loc_4:Graph = null;
            this.addConstValue(FpsManagerConst.SPECIAL_GRAPH[1].name, 1000 / StageShareManager.stage.frameRate);
            var _loc_1:* = FpsManagerConst.BOX_WIDTH - 1;
            this._graphDisplay.bitmapData.lock();
            this._graphDisplay.bitmapData.scroll(-1, 0);
            this._graphDisplay.bitmapData.fillRect(new Rectangle(_loc_1, 1, 1, FpsManagerConst.BOX_HEIGHT), 16711680);
            for each (_loc_4 in this._graphToDisplay)
            {
                
                if (!FpsManagerUtils.isSpecialGraph(_loc_4.indice))
                {
                    this.addConstValue(_loc_4.indice);
                }
                _loc_4.setNewFrame();
                if (_loc_4.points.length == 0 || !_loc_4.graphVisible)
                {
                    continue;
                }
                _loc_2 = this.formateValue(_loc_4.points[(_loc_4.points.length - 1)]);
                _loc_3 = FpsManagerUtils.addAlphaToColor(_loc_4.color, 4294967295);
                if (_loc_4.points.length >= 2)
                {
                    this.linkGraphValues(_loc_1, _loc_2, this.formateValue(_loc_4.points[_loc_4.points.length - 2]), _loc_3);
                }
                this._graphDisplay.bitmapData.setPixel32(_loc_1, _loc_2, _loc_2 == 1 ? (4294901760) : (_loc_3));
            }
            this._graphDisplay.bitmapData.unlock();
            return;
        }// end function

        public function updateFpsValue(param1:Number) : void
        {
            this._fpsTf.text = param1.toFixed(1) + " FPS";
            return;
        }// end function

        public function get memory() : String
        {
            return this._memTf.text;
        }// end function

        public function set memory(param1:String) : void
        {
            this._memTf.text = param1;
            return;
        }// end function

        public function startTracking(param1:String, param2:uint = 16777215) : void
        {
            var _loc_3:* = this._graphToDisplay[param1];
            if (_loc_3 == null)
            {
                _loc_3 = new Graph(param1, param2);
                _loc_3.addEventListener("showGraph", this.showGraph);
                _loc_3.addEventListener("hideGraph", this.hideGraph);
                if (!FpsManagerUtils.isSpecialGraph(param1))
                {
                    _loc_3.setMenuPosition((FpsManagerUtils.countKeys(this._graphToDisplay) - FpsManagerUtils.numberOfSpecialGraphDisplayed(this._graphToDisplay)) * 24, -25);
                }
                this._graphSpr.addChild(_loc_3);
                this._graphToDisplay[param1] = _loc_3;
            }
            _loc_3.startTime = getTimer();
            return;
        }// end function

        public function stopTracking(param1:String) : void
        {
            var _loc_2:* = this._graphToDisplay[param1];
            if (_loc_2 == null)
            {
                return;
            }
            var _loc_3:* = getTimer() - _loc_2.startTime;
            _loc_2.insertNewValue(_loc_3);
            _loc_2.startTime = 0;
            if (_loc_2.points.length > FpsManagerConst.BOX_WIDTH)
            {
                _loc_2.points.shift();
            }
            return;
        }// end function

        public function addConstValue(param1:String, param2:int = 0) : void
        {
            var _loc_3:* = this._graphToDisplay[param1];
            if (_loc_3 == null)
            {
                return;
            }
            _loc_3.insertNewValue(param2);
            if (_loc_3.points.length > FpsManagerConst.BOX_WIDTH)
            {
                _loc_3.points.shift();
            }
            return;
        }// end function

        private function showGraph(event:Event) : void
        {
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_2:* = event.currentTarget as Graph;
            var _loc_3:* = _loc_2.points.length;
            var _loc_4:int = 0;
            var _loc_7:* = FpsManagerUtils.addAlphaToColor(_loc_2.color, 4294967295);
            this._graphDisplay.bitmapData.lock();
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_3 < FpsManagerConst.BOX_WIDTH ? (FpsManagerConst.BOX_WIDTH - _loc_3 + _loc_4) : (_loc_4);
                _loc_6 = this.formateValue(_loc_2.points[_loc_4]);
                if (_loc_2.points.length >= 2)
                {
                    this.linkGraphValues(_loc_5, _loc_6, this.formateValue(_loc_2.points[_loc_2.points.length - 2]), _loc_7);
                }
                this._graphDisplay.bitmapData.setPixel32(_loc_5, _loc_6, _loc_7);
                _loc_4++;
            }
            this._graphDisplay.bitmapData.unlock();
            return;
        }// end function

        private function hideGraph(event:Event) : void
        {
            return;
        }// end function

        private function formateValue(param1:int) : int
        {
            var _loc_2:* = FpsManagerConst.BOX_HEIGHT - 1;
            if (param1 < 1)
            {
                param1 = 1;
            }
            else if (param1 > _loc_2)
            {
                param1 = _loc_2;
            }
            return param1 * -1 + FpsManagerConst.BOX_HEIGHT;
        }// end function

        private function linkGraphValues(param1:int, param2:int, param3:int, param4:uint) : void
        {
            if (Math.abs(param2 - param3) > 1)
            {
                this._graphDisplay.bitmapData.fillRect(new Rectangle((param1 - 1), (param2 > param3 ? (param3) : (param2)) + 1, 1, (Math.abs(param2 - param3) - 1)), param4);
            }
            return;
        }// end function

    }
}
