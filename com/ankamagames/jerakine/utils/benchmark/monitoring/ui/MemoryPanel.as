package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;

    public class MemoryPanel extends Sprite
    {
        private var _otherData:Dictionary;
        private var _memGraph:Bitmap;
        private var _memoryGraph:Vector.<Number>;
        private var _memoryLimits:Vector.<Number>;
        private var _lastTimer:int = 0;
        private var _infosTf:TextField;
        public var lastGc:int;
        private static var MAX_THEO_VALUE:int = 250;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(MemoryPanel));

        public function MemoryPanel()
        {
            this.drawBG();
            this.init();
            return;
        }// end function

        private function drawBG() : void
        {
            graphics.beginFill(FpsManagerConst.BOX_COLOR, 0.7);
            graphics.lineStyle(2, FpsManagerConst.BOX_COLOR);
            graphics.drawRoundRect(0, 0, FpsManagerConst.BOX_WIDTH, FpsManagerConst.BOX_HEIGHT, 8, 8);
            graphics.endFill();
            return;
        }// end function

        private function init() : void
        {
            this._memoryGraph = new Vector.<Number>;
            this._memoryLimits = new Vector.<Number>;
            this._otherData = new Dictionary();
            var _loc_1:* = new TextFormat("Verdana", 13);
            _loc_1.color = 16777215;
            this._infosTf = new TextField();
            this._infosTf.y = FpsManagerConst.BOX_HEIGHT - 20;
            this._infosTf.x = 4;
            this._infosTf.defaultTextFormat = _loc_1;
            this._infosTf.selectable = false;
            this._infosTf.addEventListener(MouseEvent.MOUSE_UP, this.forceGC);
            addChild(this._infosTf);
            return;
        }// end function

        private function forceGC(event:MouseEvent) : void
        {
            System.gc();
            this.lastGc = getTimer();
            return;
        }// end function

        public function updateData() : void
        {
            this._memoryGraph.push(FpsManagerUtils.calculateMB(System.totalMemory));
            this._memoryLimits.push(MAX_THEO_VALUE);
            if (this._memoryGraph.length > FpsManagerConst.BOX_WIDTH)
            {
                this._memoryGraph.shift();
                this._memoryLimits.shift();
            }
            return;
        }// end function

        public function initMemGraph() : void
        {
            if (this._memGraph == null)
            {
                this._memGraph = new Bitmap(new BitmapData(FpsManagerConst.BOX_WIDTH, FpsManagerConst.BOX_HEIGHT, true, 0));
                this._memGraph.smoothing = true;
                addChild(this._memGraph);
            }
            this.drawLine(this._memoryGraph, this._memoryLimits, 4294967295);
            return;
        }// end function

        public function render() : void
        {
            var _loc_1:* = null;
            this._memGraph.bitmapData.lock();
            this._memGraph.bitmapData.scroll(-1, 0);
            this._memGraph.bitmapData.fillRect(new Rectangle((FpsManagerConst.BOX_WIDTH - 1), 1, 1, FpsManagerConst.BOX_HEIGHT), 16711680);
            for each (_loc_1 in this._otherData)
            {
                
                if (_loc_1 != null && _loc_1.selected)
                {
                    this.drawGraphValue(_loc_1.data, _loc_1.limits, FpsManagerUtils.addAlphaToColor(_loc_1.color, 4294967295));
                }
            }
            this.drawGraphValue(this._memoryGraph, this._memoryLimits, 4294967295);
            this._memGraph.bitmapData.unlock();
            return;
        }// end function

        private function drawGraphValue(param1:Vector.<Number>, param2:Vector.<Number>, param3:uint) : void
        {
            var _loc_5:* = 0;
            var _loc_7:* = NaN;
            var _loc_4:* = FpsManagerConst.BOX_WIDTH - 1;
            var _loc_6:* = param2 == null ? (MAX_THEO_VALUE) : (param2[(param1.length - 1)]);
            _loc_5 = this.getGraphValue(param1, (param1.length - 1), _loc_6);
            if (param1.length >= 2)
            {
                _loc_7 = param2 == null ? (MAX_THEO_VALUE) : (param2[param1.length - 2]);
                this.linkGraphValues(_loc_4, _loc_5, this.getGraphValue(param1, param1.length - 2, _loc_7), param3);
            }
            this._memGraph.bitmapData.setPixel32(_loc_4, _loc_5, param3);
            return;
        }// end function

        public function clearOtherGraph() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._otherData)
            {
                
                if (_loc_1 != null)
                {
                    this.removeGraph(_loc_1);
                }
            }
            removeChild(this._memGraph);
            this._memGraph.bitmapData.dispose();
            this._memGraph = null;
            return;
        }// end function

        public function addNewGraph(param1:MonitoredObject) : void
        {
            if (this._otherData[param1.name] != null)
            {
                this.removeGraph(param1);
            }
            else
            {
                param1.selected = true;
                this._otherData[param1.name] = param1;
                this.drawLine(param1.data, param1.limits, FpsManagerUtils.addAlphaToColor(param1.color, 4294967295));
            }
            return;
        }// end function

        public function removeGraph(param1:MonitoredObject) : void
        {
            param1.selected = false;
            this._otherData[param1.name] = null;
            this.drawLine(param1.data, param1.limits);
            return;
        }// end function

        private function drawLine(param1:Vector.<Number>, param2:Vector.<Number>, param3:uint = 16711680) : void
        {
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = param1.length;
            var _loc_7:* = 0;
            _loc_7 = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_4 = _loc_6 < FpsManagerConst.BOX_WIDTH ? (FpsManagerConst.BOX_WIDTH - _loc_6 + _loc_7) : (_loc_7);
                _loc_8 = param2 == null ? (MAX_THEO_VALUE) : (param2[_loc_7]);
                _loc_5 = this.getGraphValue(param1, _loc_7, _loc_8);
                if (_loc_7 != 0)
                {
                    _loc_9 = param2 == null ? (MAX_THEO_VALUE) : (param2[(_loc_7 - 1)]);
                    this.linkGraphValues(_loc_4, _loc_5, this.getGraphValue(param1, (_loc_7 - 1), _loc_9), param3);
                }
                this._memGraph.bitmapData.setPixel32(_loc_4, _loc_5, param3);
                _loc_7++;
            }
            return;
        }// end function

        public function updateGc(param1:Number = 0) : void
        {
            if (param1 > 0)
            {
                MAX_THEO_VALUE = Math.ceil(param1);
            }
            this._infosTf.text = "GC " + FpsManagerUtils.getTimeFromNow(this.lastGc);
            return;
        }// end function

        private function getGraphValue(param1:Vector.<Number>, param2:int, param3:int = -1) : int
        {
            if (param3 == -1)
            {
                var _loc_6:* = FpsManagerUtils.getVectorMaxValue(param1);
                param3 = FpsManagerUtils.getVectorMaxValue(param1);
                param3 = _loc_6;
            }
            var _loc_4:* = Math.floor(param1[param2] / param3 * FpsManagerConst.BOX_HEIGHT * -1 + FpsManagerConst.BOX_HEIGHT);
            var _loc_5:* = FpsManagerConst.BOX_HEIGHT - 1;
            if (_loc_4 < 1)
            {
                _loc_4 = 1;
            }
            else if (_loc_4 > _loc_5)
            {
                _loc_4 = _loc_5;
            }
            return _loc_4;
        }// end function

        private function linkGraphValues(param1:int, param2:int, param3:int, param4:uint) : void
        {
            if (Math.abs(param2 - param3) > 1)
            {
                this._memGraph.bitmapData.fillRect(new Rectangle((param1 - 1), (param2 > param3 ? (param3) : (param2)) + 1, 1, (Math.abs(param2 - param3) - 1)), param4);
            }
            return;
        }// end function

    }
}
