package com.ankamagames.dofus.misc.options
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.types.*;
    import flash.utils.*;

    dynamic public class ChatOptions extends OptionManager
    {
        public var colors:Array;
        private var _cssUri:String;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ChatOptions));

        public function ChatOptions()
        {
            this.colors = new Array();
            this._cssUri = XmlConfig.getInstance().getEntry("config.ui.skin") + "css/chat.css";
            super("chat");
            add("channelLocked", false);
            add("filterInsult", true);
            add("letLivingObjectTalk", true);
            add("smileysAutoclosed", false);
            add("showTime", false);
            add("showShortcut", false);
            add("chatFontSize", 1);
            add("chatExpertMode", true);
            add("channelTabs", [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13], [11], [9], [2]]);
            add("tabsNames", ["0", "1", "2", "3"]);
            add("chatoutput", false);
            add("currentChatTheme", "");
            CssManager.getInstance().askCss(this._cssUri, new Callback(this.onCssLoaded));
            return;
        }// end function

        private function onCssLoaded() : void
        {
            var _loc_2:Object = null;
            var _loc_1:* = CssManager.getInstance().getCss(this._cssUri);
            var _loc_3:* = OptionManager.getOptionManager("dofus").switchUiSkin;
            var _loc_4:* = OptionManager.getOptionManager("chat").currentChatTheme;
            var _loc_5:int = 0;
            while (_loc_5 < 14)
            {
                
                _loc_2 = _loc_1.getStyle("p" + _loc_5);
                this.colors[_loc_5] = uint(this.color0x(_loc_2["color"]));
                add("channelColor" + _loc_5, this.colors[_loc_5]);
                if (_loc_3 != _loc_4)
                {
                    OptionManager.getOptionManager("chat")["channelColor" + _loc_5] = this.colors[_loc_5];
                }
                _loc_5++;
            }
            if (_loc_3 != _loc_4)
            {
                OptionManager.getOptionManager("chat").currentChatTheme = _loc_3;
            }
            _loc_2 = _loc_1.getStyle("p");
            add("alertColor", uint(this.color0x(_loc_2["color"])));
            return;
        }// end function

        private function color0x(param1:String) : String
        {
            return param1.replace("#", "0x");
        }// end function

    }
}
