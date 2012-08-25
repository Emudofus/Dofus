package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectsDeletedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var objectUID:Vector.<uint>;
        public static const protocolId:uint = 6034;

        public function ObjectsDeletedMessage()
        {
            this.objectUID = new Vector.<uint>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6034;
        }// end function

        public function initObjectsDeletedMessage(param1:Vector.<uint> = null) : ObjectsDeletedMessage
        {
            this.objectUID = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.objectUID = new Vector.<uint>;
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
            this.serializeAs_ObjectsDeletedMessage(param1);
            return;
        }// end function

        public function serializeAs_ObjectsDeletedMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.objectUID.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.objectUID.length)
            {
                
                if (this.objectUID[_loc_2] < 0)
                {
                    throw new Error("Forbidden value (" + this.objectUID[_loc_2] + ") on element 1 (starting at 1) of objectUID.");
                }
                param1.writeInt(this.objectUID[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectsDeletedMessage(param1);
            return;
        }// end function

        public function deserializeAs_ObjectsDeletedMessage(param1:IDataInput) : void
        {
            var _loc_4:uint = 0;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readInt();
                if (_loc_4 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_4 + ") on elements of objectUID.");
                }
                this.objectUID.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
