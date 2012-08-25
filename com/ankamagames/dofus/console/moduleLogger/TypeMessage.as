package com.ankamagames.dofus.console.moduleLogger
{
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.shortcut.*;
    import com.ankamagames.jerakine.handlers.messages.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import flash.display.*;
    import flash.utils.*;

    final public class TypeMessage extends Object
    {
        public var name:String = "";
        public var textInfo:String;
        public var type:int = -1;
        public var logType:int = -1;
        private var search1:RegExp;
        private var search2:RegExp;
        private var vectorExp:RegExp;
        public static const TYPE_HOOK:int = 0;
        public static const TYPE_UI:int = 1;
        public static const TYPE_ACTION:int = 2;
        public static const TYPE_SHORTCUT:int = 3;
        public static const TYPE_MODULE_LOG:int = 4;
        public static const LOG:int = 5;
        public static const LOG_CHAT:int = 17;
        public static const TAB:String = "                  ";

        public function TypeMessage(... args)
        {
            args = new activation;
            var object:Object;
            var args:* = args;
            this.search1 = new RegExp("<", "g");
            this.search2 = new RegExp(">", "g");
            this.vectorExp = new RegExp("Vector.<(.*)::(.*)>", "g");
            try
            {
                object = [0];
                if ( is String && length == 2)
                {
                    this.displayLog( as String, [1]);
                }
                else if ( is Hook)
                {
                    this.displayHookInformations( as Hook, [1]);
                }
                else if ( is Action)
                {
                    this.displayActionInformations( as Action);
                }
                else if ( is Message)
                {
                    this.displayInteractionMessage( as Message, [1]);
                }
                else if ( is Bind)
                {
                    this.displayBind( as Bind, [1]);
                }
                else
                {
                    this.name = "trace";
                    this.textInfo =  as String;
                    this.type = LOG;
                }
            }
            catch (e:Error)
            {
                if (!(e is String))
                {
                    name = "trace";
                    textInfo = "<span class=\'red\'>" + e.getStackTrace() + "</span>";
                }
            }
            return;
        }// end function

        private function displayBind(param1:Bind, param2:Object) : void
        {
            this.type = TYPE_SHORTCUT;
            var _loc_3:* = "Shortcut : " + param1.key.toUpperCase() + " --&gt; \"" + param1.targetedShortcut + "\" " + (param1.alt ? ("Alt+") : ("")) + (param1.ctrl ? ("Ctrl+") : ("")) + (param1.shift ? ("Shift+") : (""));
            this.name = "Shortcut";
            this.textInfo = "<span class=\'gray\'>[" + this.getDate() + "]</span>" + "<span class=\'yellow\'> BIND   : <a href=\'event:@shortcut\'>" + _loc_3 + "</a></span>" + "\n<span class=\'gray+\'>" + TAB + "target : " + param2 + "</span>\n";
            return;
        }// end function

        private function displayInteractionMessage(param1:Message, param2:DisplayObject) : void
        {
            var _loc_6:Array = null;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            this.type = TYPE_UI;
            var _loc_3:* = getQualifiedClassName(param1);
            if (_loc_3.indexOf("::") != -1)
            {
                _loc_3 = _loc_3.split("::")[1];
            }
            this.name = _loc_3;
            var _loc_4:* = "<span class=\'gray\'>[" + this.getDate() + "]</span>" + "<span class=\'green\'> UI     : <a href=\'event:@" + this.name + "\'>" + this.name + "</a></span>" + "\n<span class=\'gray+\'>" + TAB + "target : " + param2.name + "</span><span class=\'gray\'>";
            var _loc_5:* = String(param1);
            if (String(param1).indexOf("@") != -1)
            {
                _loc_6 = _loc_5.split("@");
                _loc_7 = _loc_6.length;
                _loc_8 = 1;
                while (_loc_8 < _loc_7)
                {
                    
                    _loc_4 = _loc_4 + ("\n" + TAB + _loc_6[_loc_8]);
                    _loc_8++;
                }
            }
            this.textInfo = _loc_4 + "</span>\n";
            return;
        }// end function

        private function displayHookInformations(param1:Hook, param2:Array) : void
        {
            var _loc_6:Object = null;
            var _loc_7:String = null;
            var _loc_8:String = null;
            this.type = TYPE_HOOK;
            this.name = param1.name;
            var _loc_3:* = "<span class=\'gray\'>[" + this.getDate() + "]</span>" + "<span class=\'blue\'> HOOK   : <a href=\'event:@" + this.name + "\'>" + this.name + "</a></span>" + "<span class=\'gray\'>";
            var _loc_4:* = param2.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = param2[_loc_5];
                _loc_7 = getQualifiedClassName(_loc_6);
                _loc_7 = _loc_7.replace(this.vectorExp, "Vector.<$2>");
                _loc_7 = _loc_7.replace(this.search1, "&lt;");
                _loc_7 = _loc_7.replace(this.search2, "&gt;");
                if (_loc_7.indexOf("::") != -1)
                {
                    _loc_7 = _loc_7.split("::")[1];
                }
                if (_loc_6 != null)
                {
                    _loc_8 = _loc_6.toString();
                    _loc_8 = _loc_8.replace(this.search1, "&lt;");
                    _loc_8 = _loc_8.replace(this.search2, "&gt;");
                }
                _loc_3 = _loc_3 + ("\n" + TAB + "arg" + _loc_5 + ":" + _loc_7 + " = " + _loc_8);
                _loc_5++;
            }
            _loc_3 = _loc_3 + "</span>\n";
            this.textInfo = _loc_3;
            return;
        }// end function

        private function displayLog(param1:String, param2:int) : void
        {
            var _loc_3:String = null;
            this.name = param1;
            if (param2 == LogLevel.DEBUG)
            {
                _loc_3 = "<span class=\'blue\'>";
            }
            else if (param2 == LogLevel.TRACE)
            {
                _loc_3 = "<span class=\'green\'>";
            }
            else if (param2 == LogLevel.INFO)
            {
                _loc_3 = "<span class=\'yellow\'>";
            }
            else if (param2 == LogLevel.WARN)
            {
                _loc_3 = "<span class=\'orange\'>";
            }
            else if (param2 == LogLevel.ERROR)
            {
                _loc_3 = "<span class=\'red\'>";
            }
            else if (param2 == LogLevel.FATAL)
            {
                _loc_3 = "<span class=\'red+\'>";
            }
            else if (param2 == LOG_CHAT)
            {
                this.logType = LOG_CHAT;
                _loc_3 = "<span class=\'white\'>";
            }
            else
            {
                _loc_3 = "<span class=\'gray\'>";
            }
            _loc_3 = _loc_3 + ("[" + this.getDate() + "] " + param1 + "</span>");
            this.textInfo = _loc_3;
            return;
        }// end function

        private function displayActionInformations(param1:Action) : void
        {
            var _loc_6:XML = null;
            var _loc_7:String = null;
            var _loc_8:String = null;
            var _loc_9:String = null;
            this.type = TYPE_ACTION;
            var _loc_2:* = getQualifiedClassName(param1).split("::")[1];
            this.name = _loc_2;
            var _loc_3:* = "<span class=\'gray\'>[" + this.getDate() + "]</span>" + "<span class=\'pink\'> ACTION : <a href=\'event:@" + this.name + "\'>" + this.name + "</a></span>" + "<span class=\'gray\'>";
            var _loc_4:* = describeType(param1);
            var _loc_5:* = describeType(param1).elements("variable");
            for each (_loc_6 in _loc_5)
            {
                
                _loc_7 = _loc_6.attribute("name");
                _loc_8 = _loc_6.attribute("type");
                _loc_8 = _loc_8.replace(this.search1, "&lt;");
                _loc_8 = _loc_8.replace(this.search2, "&gt;");
                _loc_9 = String(param1[_loc_7]);
                _loc_9 = _loc_9.replace(this.search1, "&lt;");
                _loc_9 = _loc_9.replace(this.search2, "&gt;");
                _loc_3 = _loc_3 + ("\n" + TAB + _loc_7 + ":" + _loc_8 + " = " + _loc_9);
            }
            _loc_3 = _loc_3 + "</span>\n";
            this.textInfo = _loc_3;
            return;
        }// end function

        private function getDate() : String
        {
            var _loc_1:* = new Date();
            var _loc_2:* = _loc_1.hours;
            var _loc_3:* = _loc_1.minutes;
            var _loc_4:* = _loc_1.seconds;
            return (_loc_2 < 10 ? ("0" + _loc_2) : (_loc_2)) + ":" + (_loc_3 < 10 ? ("0" + _loc_3) : (_loc_3)) + ":" + (_loc_4 < 10 ? ("0" + _loc_4) : (_loc_4));
        }// end function

    }
}
