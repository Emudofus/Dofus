package com.ankamagames.berilia.types.messages
{
    import com.ankamagames.jerakine.messages.Message;

    public class ModuleLoadedMessage implements Message 
    {

        private var _moduleName:String;

        public function ModuleLoadedMessage(moduleName:String)
        {
            this._moduleName = moduleName;
        }

        public function get moduleName():String
        {
            return (this._moduleName);
        }


    }
}//package com.ankamagames.berilia.types.messages

