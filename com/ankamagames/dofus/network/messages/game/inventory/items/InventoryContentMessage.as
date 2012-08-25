package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class InventoryContentMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var objects:Vector.<ObjectItem>;
        public var kamas:uint = 0;
        public static const protocolId:uint = 3016;

        public function InventoryContentMessage()
        {
            this.objects = new Vector.<ObjectItem>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 3016;
        }// end function

        public function initInventoryContentMessage(param1:Vector.<ObjectItem> = null, param2:uint = 0) : InventoryContentMessage
        {
            this.objects = param1;
            this.kamas = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.objects = new Vector.<ObjectItem>;
            this.kamas = 0;
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
            this.serializeAs_InventoryContentMessage(param1);
            return;
        }// end function

        public function serializeAs_InventoryContentMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.objects.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.objects.length)
            {
                
                (this.objects[_loc_2] as ObjectItem).serializeAs_ObjectItem(param1);
                _loc_2 = _loc_2 + 1;
            }
            if (this.kamas < 0)
            {
                throw new Error("Forbidden value (" + this.kamas + ") on element kamas.");
            }
            param1.writeInt(this.kamas);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_InventoryContentMessage(param1);
            return;
        }// end function

        public function deserializeAs_InventoryContentMessage(param1:IDataInput) : void
        {
            var _loc_4:ObjectItem = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new ObjectItem();
                _loc_4.deserialize(param1);
                this.objects.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            this.kamas = param1.readInt();
            if (this.kamas < 0)
            {
                throw new Error("Forbidden value (" + this.kamas + ") on element of InventoryContentMessage.kamas.");
            }
            return;
        }// end function

    }
}
