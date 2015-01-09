package com.ankamagames.dofus.kernel.updaterv2.messages.impl
{
    import com.ankamagames.dofus.kernel.updaterv2.messages.IUpdaterInputMessage;

    public class SystemConfigurationMessage implements IUpdaterInputMessage 
    {

        private var _config;


        public function get config()
        {
            return (this._config);
        }

        public function deserialize(data:Object):void
        {
            this._config = data;
        }


    }
}//package com.ankamagames.dofus.kernel.updaterv2.messages.impl

