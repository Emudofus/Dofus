package com.ankamagames.tiphon.engine
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.tiphon.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;

    final public class TiphonDebugManager extends Object
    {
        private static var _enabled:Boolean = false;
        private static var _textList:Vector.<Object> = new Vector.<Object>;

        public function TiphonDebugManager()
        {
            return;
        }// end function

        public static function enable() : void
        {
            _enabled = true;
            return;
        }// end function

        public static function disable() : void
        {
            _enabled = false;
            return;
        }// end function

        public static function displayDofusScriptError(param1:String, param2:TiphonSprite) : void
        {
            var _loc_3:TextField = null;
            var _loc_4:Timer = null;
            var _loc_5:Point = null;
            if (_enabled && param2)
            {
                _loc_3 = new TextField();
                _loc_3.defaultTextFormat = new TextFormat("Verdana", 14, 16777215, true, null, null, null, null, "center");
                _loc_3.filters = new Array(new GlowFilter(16711680, 1, 3, 3, 3, 3));
                _loc_3.text = param1 + "\n" + (param2.look ? (param2.look.toString()) : (""));
                _loc_3.autoSize = TextFieldAutoSize.LEFT;
                _loc_3.mouseEnabled = false;
                _loc_4 = new Timer(10000, 1);
                _loc_4.addEventListener(TimerEvent.TIMER, onTimer);
                _loc_4.start();
                _textList.push(_loc_4, _loc_3);
                StageShareManager.stage.addChild(_loc_3);
                _loc_5 = param2.localToGlobal(new Point(0, 0));
                _loc_3.x = _loc_5.x - _loc_3.width / 2;
                _loc_3.y = _loc_5.y - param2.height / 2 + (20 - Math.random() * 40);
            }
            return;
        }// end function

        private static function onTimer(event:TimerEvent) : void
        {
            var _loc_5:TextField = null;
            var _loc_2:* = event.currentTarget as Timer;
            var _loc_3:* = _textList.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (_loc_2 == _textList[_loc_4])
                {
                    _loc_5 = _textList[(_loc_4 + 1)] as TextField;
                    if (_loc_5.parent)
                    {
                        _loc_5.parent.removeChild(_loc_5);
                    }
                    _textList.splice(_loc_4, 2);
                    return;
                }
                _loc_4 = _loc_4 + 2;
            }
            return;
        }// end function

    }
}
