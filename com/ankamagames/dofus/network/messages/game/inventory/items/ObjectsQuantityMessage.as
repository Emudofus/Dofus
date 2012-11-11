package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectsQuantityMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var objectsUIDAndQty:Vector.<ObjectItemQuantity>;
        public static const protocolId:uint = 6206;

        public function ObjectsQuantityMessage()
        {
            this.objectsUIDAndQty = new Vector.<ObjectItemQuantity>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6206;
        }// end function

        public function initObjectsQuantityMessage(param1:Vector.<ObjectItemQuantity> = null) : ObjectsQuantityMessage
        {
            this.objectsUIDAndQty = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.objectsUIDAndQty = new Vector.<ObjectItemQuantity>;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ObjectsQuantityMessage(param1);
            return;
        }// end function

        public function serializeAs_ObjectsQuantityMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.objectsUIDAndQty.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.objectsUIDAndQty.length)
            {
                
                (this.objectsUIDAndQty[_loc_2] as ObjectItemQuantity).serializeAs_ObjectItemQuantity(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectsQuantityMessage(param1);
            return;
        }// end function

        public function deserializeAs_ObjectsQuantityMessage(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new ObjectItemQuantity();
                _loc_4.deserialize(param1);
                this.objectsUIDAndQty.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
