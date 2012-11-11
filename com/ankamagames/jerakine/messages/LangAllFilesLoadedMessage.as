package com.ankamagames.jerakine.messages
{
    import com.ankamagames.jerakine.messages.*;

    public class LangAllFilesLoadedMessage extends Object implements Message
    {
        private var _sFile:String;
        private var _bSuccess:Boolean;

        public function LangAllFilesLoadedMessage(param1:String, param2:Boolean)
        {
            this._sFile = param1;
            this._bSuccess = param2;
            return;
        }// end function

        public function get file() : String
        {
            return this._sFile;
        }// end function

        public function get success() : Boolean
        {
            return this._bSuccess;
        }// end function

    }
}
