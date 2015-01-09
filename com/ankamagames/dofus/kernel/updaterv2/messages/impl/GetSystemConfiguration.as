package com.ankamagames.dofus.kernel.updaterv2.messages.impl
{
    import com.ankamagames.dofus.kernel.updaterv2.messages.IUpdaterOutputMessage;
    import by.blooddy.crypto.serialization.JSON;
    import com.ankamagames.dofus.kernel.updaterv2.messages.UpdaterMessageIDEnum;

    public class GetSystemConfiguration implements IUpdaterOutputMessage 
    {

        private var _key:String = "";

        public function GetSystemConfiguration(key:String="")
        {
            this._key = key;
        }

        public function serialize():String
        {
            return (JSON.encode({
                "_msg_id":UpdaterMessageIDEnum.GET_SYSTEM_CONFIGURATION,
                "key":this._key
            }));
        }


    }
}//package com.ankamagames.dofus.kernel.updaterv2.messages.impl

