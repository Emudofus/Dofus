package com.ankamagames.dofus.logic.connection.messages
{
    import com.ankamagames.jerakine.messages.Message;

    public class UpdaterConnectionStatusMessage implements Message 
    {

        private var _success:Boolean;

        public function UpdaterConnectionStatusMessage(pSuccess:Boolean)
        {
            this._success = pSuccess;
        }

        public function get success():Boolean
        {
            return (this._success);
        }


    }
}//package com.ankamagames.dofus.logic.connection.messages

