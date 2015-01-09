package com.ankamagames.dofus.kernel.updaterv2.messages.impl
{
    import com.ankamagames.dofus.kernel.updaterv2.messages.IUpdaterOutputMessage;
    import by.blooddy.crypto.serialization.JSON;
    import com.ankamagames.dofus.kernel.updaterv2.messages.UpdaterMessageIDEnum;

    public class GetComponentsListMessage implements IUpdaterOutputMessage 
    {

        private var _project:String;

        public function GetComponentsListMessage(project:String="game")
        {
            this._project = project;
        }

        public function serialize():String
        {
            return (JSON.encode({
                "_msg_id":UpdaterMessageIDEnum.GET_COMPONENTS_LIST,
                "project":this._project
            }));
        }


    }
}//package com.ankamagames.dofus.kernel.updaterv2.messages.impl

