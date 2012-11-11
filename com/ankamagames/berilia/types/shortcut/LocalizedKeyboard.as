package com.ankamagames.berilia.types.shortcut
{
    import com.ankamagames.jerakine.types.*;

    public class LocalizedKeyboard extends Object
    {
        private var _uri:Uri;
        private var _locale:String;
        private var _description:String;

        public function LocalizedKeyboard(param1:Uri, param2:String, param3:String)
        {
            this._uri = param1;
            this._locale = param2;
            this._description = param3;
            return;
        }// end function

        public function get uri() : Uri
        {
            return this._uri;
        }// end function

        public function get locale() : String
        {
            return this._locale;
        }// end function

        public function get description() : String
        {
            return this._description;
        }// end function

    }
}
