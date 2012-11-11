package com.ankamagames.jerakine.console
{
    import com.ankamagames.jerakine.messages.*;

    public class ConsoleOutputMessage extends Object implements Message
    {
        private var _consoleId:String;
        private var _text:String;

        public function ConsoleOutputMessage(param1:String, param2:String)
        {
            this._consoleId = param1;
            this._text = param2;
            return;
        }// end function

        public function get consoleId() : String
        {
            return this._consoleId;
        }// end function

        public function get text() : String
        {
            return this._text;
        }// end function

    }
}
