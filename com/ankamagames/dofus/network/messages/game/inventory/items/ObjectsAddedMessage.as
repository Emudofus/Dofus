package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectsAddedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var object:Vector.<ObjectItem>;
        public static const protocolId:uint = 6033;

        public function ObjectsAddedMessage()
        {
            this.object = new Vector.<ObjectItem>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6033;
        }// end function

        public function initObjectsAddedMessage(param1:Vector.<ObjectItem> = null) : ObjectsAddedMessage
        {
            this.object = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.object = new Vector.<ObjectItem>;
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
            this.serializeAs_ObjectsAddedMessage(param1);
            return;
        }// end function

        public function serializeAs_ObjectsAddedMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.object.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.object.length)
            {
                
                (this.object[_loc_2] as ObjectItem).serializeAs_ObjectItem(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectsAddedMessage(param1);
            return;
        }// end function

        public function deserializeAs_ObjectsAddedMessage(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new ObjectItem();
                _loc_4.deserialize(param1);
                this.object.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
