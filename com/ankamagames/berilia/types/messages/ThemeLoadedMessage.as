package com.ankamagames.berilia.types.messages
{
    import com.ankamagames.jerakine.messages.*;

    public class ThemeLoadedMessage extends Object implements Message
    {
        private var _themeName:String;

        public function ThemeLoadedMessage(param1:String)
        {
            this._themeName = param1;
            return;
        }// end function

        public function get themeName() : String
        {
            return this._themeName;
        }// end function

    }
}
