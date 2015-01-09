package com.ankamagames.berilia.types.messages
{
    import com.ankamagames.jerakine.messages.Message;

    public class ThemeLoadErrorMessage implements Message 
    {

        private var _themeName:String;

        public function ThemeLoadErrorMessage(themeName:String)
        {
            this._themeName = themeName;
        }

        public function get themeName():String
        {
            return (this._themeName);
        }


    }
}//package com.ankamagames.berilia.types.messages

