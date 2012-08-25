package com.ankamagames.berilia.factories
{
    import com.ankamagames.berilia.frames.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.utils.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class HyperlinkFactory extends Object
    {
        private static var LEFT:String = "{";
        private static var RIGHT:String = "}";
        private static var SEPARATOR:String = "::";
        private static var PROTOCOL:Dictionary = new Dictionary();
        private static var PROTOCOL_TEXT:Dictionary = new Dictionary();
        private static var PROTOCOL_SHIFT:Dictionary = new Dictionary();
        private static var PROTOCOL_BOLD:Dictionary = new Dictionary();
        private static var staticStyleSheet:StyleSheet;
        public static var lastClickEventFrame:uint;

        public function HyperlinkFactory()
        {
            return;
        }// end function

        public static function protocolIsRegister(param1:String) : Boolean
        {
            return PROTOCOL[param1] ? (true) : (false);
        }// end function

        public static function textProtocolIsRegister(param1:String) : Boolean
        {
            return PROTOCOL_TEXT[param1] ? (true) : (false);
        }// end function

        public static function shiftProtocolIsRegister(param1:String) : Boolean
        {
            return PROTOCOL_SHIFT[param1] ? (true) : (false);
        }// end function

        public static function boldProtocolIsRegister(param1:String) : Boolean
        {
            return PROTOCOL_BOLD[param1] ? (true) : (false);
        }// end function

        public static function createHyperlink(param1:TextField, param2:Boolean = false) : void
        {
            var _loc_3:* = decode(param1.htmlText, true, param2 ? (param1) : (null));
            param1.htmlText = _loc_3;
            param1.mouseEnabled = true;
            param1.addEventListener(TextEvent.LINK, process);
            return;
        }// end function

        public static function activeSmallHyperlink(param1:TextField) : void
        {
            param1.addEventListener(TextEvent.LINK, process);
            return;
        }// end function

        public static function decode(param1:String, param2:Boolean = true, param3:TextField = null) : String
        {
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:String = null;
            var _loc_8:String = null;
            var _loc_9:String = null;
            var _loc_10:Array = null;
            var _loc_11:String = null;
            var _loc_12:Array = null;
            var _loc_13:String = null;
            var _loc_14:Function = null;
            var _loc_15:String = null;
            var _loc_16:String = null;
            var _loc_17:String = null;
            var _loc_4:* = param1;
            while (true)
            {
                
                _loc_5 = _loc_4.indexOf(LEFT);
                if (_loc_5 == -1)
                {
                    break;
                }
                _loc_6 = _loc_4.indexOf(RIGHT);
                if (_loc_6 == -1)
                {
                    break;
                }
                if (_loc_5 > _loc_6)
                {
                    break;
                }
                _loc_7 = _loc_4.substring(0, _loc_5);
                _loc_8 = _loc_4.substring((_loc_6 + 1));
                _loc_9 = _loc_4.substring(_loc_5, _loc_6);
                _loc_10 = _loc_9.split("::");
                _loc_11 = _loc_10[0].substr(1);
                _loc_12 = _loc_11.split(",");
                _loc_13 = _loc_12.shift();
                if (_loc_10.length == 1)
                {
                    _loc_14 = PROTOCOL_TEXT[_loc_13];
                    if (_loc_14 != null)
                    {
                        _loc_10.push(_loc_14.apply(_loc_14, _loc_12));
                    }
                }
                if (param2)
                {
                    _loc_15 = _loc_10[1];
                    if (PROTOCOL_BOLD[_loc_13])
                    {
                        _loc_15 = "<b>" + _loc_15 + "</b>";
                    }
                    _loc_4 = _loc_7 + "<a href=\'event:" + _loc_11 + "\'>" + _loc_15 + "</a>" + _loc_8;
                    if (param3)
                    {
                        if (!staticStyleSheet)
                        {
                            _loc_16 = XmlConfig.getInstance().getEntry("colors.hyperlink.link");
                            _loc_16 = _loc_16.replace("0x", "#");
                            _loc_17 = XmlConfig.getInstance().getEntry("colors.hyperlink.hover");
                            _loc_17 = _loc_17.replace("0x", "#");
                            staticStyleSheet = new StyleSheet();
                            staticStyleSheet.setStyle("a:link", {color:_loc_16});
                            staticStyleSheet.setStyle("a:hover", {color:_loc_17});
                        }
                        param3.styleSheet = staticStyleSheet;
                    }
                    continue;
                }
                _loc_4 = _loc_7 + _loc_10[1] + _loc_8;
            }
            return _loc_4;
        }// end function

        public static function registerProtocol(param1:String, param2:Function, param3:Function = null, param4:Function = null, param5:Boolean = true) : void
        {
            PROTOCOL[param1] = param2;
            if (param3 != null)
            {
                PROTOCOL_TEXT[param1] = param3;
            }
            if (param4 != null)
            {
                PROTOCOL_SHIFT[param1] = param4;
            }
            if (param5)
            {
                PROTOCOL_BOLD[param1] = true;
            }
            return;
        }// end function

        public static function process(event:TextEvent) : void
        {
            var _loc_3:Function = null;
            var _loc_4:Function = null;
            lastClickEventFrame = FrameIdManager.frameId;
            StageShareManager.stage.focus = StageShareManager.stage;
            var _loc_2:* = event.text.split(",");
            if (ShortcutsFrame.shiftKey)
            {
                _loc_3 = PROTOCOL_SHIFT[_loc_2[0]];
                if (_loc_3 == null)
                {
                    KernelEventsManager.getInstance().processCallback(BeriliaHookList.ChatHyperlink, "{" + _loc_2.join(",") + "}");
                }
                else
                {
                    _loc_2.shift();
                    _loc_3.apply(null, _loc_2);
                }
            }
            else
            {
                _loc_4 = PROTOCOL[_loc_2.shift()];
                if (_loc_4 != null)
                {
                    _loc_4.apply(null, _loc_2);
                }
            }
            return;
        }// end function

    }
}
