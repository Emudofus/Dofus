package com.ankamagames.berilia.types.messages
{
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;

    public class ModuleRessourceLoadFailedMessage extends Object implements Message
    {
        private var _moduleName:String;
        private var _uri:Uri;
        private var _isImportant:Boolean;

        public function ModuleRessourceLoadFailedMessage(param1:String, param2:Uri, param3:Boolean = true)
        {
            this._moduleName = param1;
            this._uri = param2;
            this._isImportant = param3;
            return;
        }// end function

        public function get moduleName() : String
        {
            return this._moduleName;
        }// end function

        public function get uri() : Uri
        {
            return this._uri;
        }// end function

        public function get isImportant() : Boolean
        {
            return this._isImportant;
        }// end function

    }
}
