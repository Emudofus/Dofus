package com.ankamagames.jerakine.entities.messages
{
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.jerakine.entities.interfaces.IInteractive;

    public class EntityInteractionMessage implements Message 
    {

        private var _entity:IInteractive;

        public function EntityInteractionMessage(entity:IInteractive)
        {
            this._entity = entity;
        }

        public function get entity():IInteractive
        {
            return (this._entity);
        }


    }
}//package com.ankamagames.jerakine.entities.messages

