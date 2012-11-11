package com.ankamagames.berilia.types.messages
{
    import com.ankamagames.jerakine.messages.*;

    public class ModuleLoadedMessage extends Object implements Message
    {
        private var _moduleName:String;

        public function ModuleLoadedMessage(param1:String)
        {
            this._moduleName = param1;
            return;
        }// end function

        public function get moduleName() : String
        {
            return this._moduleName;
        }// end function

    }
}
