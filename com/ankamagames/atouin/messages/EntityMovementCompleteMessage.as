package com.ankamagames.atouin.messages
{
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.messages.*;

    public class EntityMovementCompleteMessage extends Object implements Message, ILogableMessage
    {
        private var _entity:IEntity;
        public var id:int;

        public function EntityMovementCompleteMessage(param1:IEntity = null)
        {
            this._entity = param1;
            if (this._entity)
            {
                this.id = param1.id;
            }
            return;
        }// end function

        public function get entity() : IEntity
        {
            return this._entity;
        }// end function

    }
}
