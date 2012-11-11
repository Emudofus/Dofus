package com.ankamagames.berilia.types.messages
{
    import com.ankamagames.jerakine.messages.*;

    public class ModuleExecErrorMessage extends Object implements Message
    {
        private var _moduleName:String;
        private var _stackTrace:String;

        public function ModuleExecErrorMessage(param1:String, param2:String)
        {
            this._moduleName = param1;
            this._stackTrace = param2;
            return;
        }// end function

        public function get moduleName() : String
        {
            return this._moduleName;
        }// end function

        public function get stackTrace() : String
        {
            return this._stackTrace;
        }// end function

    }
}
