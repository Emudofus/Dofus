package com.ankamagames.dofus.types.characteristicContextual
{
    import com.ankamagames.berilia.types.event.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import flash.display.*;

    public class CharacteristicContextual extends Sprite
    {
        private var _referedEntity:IEntity;

        public function CharacteristicContextual() : void
        {
            mouseChildren = false;
            mouseEnabled = false;
            return;
        }// end function

        public function get referedEntity() : IEntity
        {
            return this._referedEntity;
        }// end function

        public function set referedEntity(param1:IEntity) : void
        {
            this._referedEntity = param1;
            return;
        }// end function

        public function remove() : void
        {
            dispatchEvent(new BeriliaEvent(BeriliaEvent.REMOVE_COMPONENT));
            return;
        }// end function

    }
}
