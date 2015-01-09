package com.ankamagames.jerakine.entities.messages
{
    import com.ankamagames.jerakine.entities.interfaces.IInteractive;

    public class EntityMouseOverMessage extends EntityInteractionMessage 
    {

        public var virtual:Boolean;

        public function EntityMouseOverMessage(entity:IInteractive, virtual:Boolean=false)
        {
            super(entity);
            this.virtual = virtual;
        }

    }
}//package com.ankamagames.jerakine.entities.messages

