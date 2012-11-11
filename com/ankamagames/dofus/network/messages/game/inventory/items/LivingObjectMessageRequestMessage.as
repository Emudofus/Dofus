package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class LivingObjectMessageRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var msgId:uint = 0;
        public var parameters:Vector.<String>;
        public var livingObject:uint = 0;
        public static const protocolId:uint = 6066;

        public function LivingObjectMessageRequestMessage()
        {
            this.parameters = new Vector.<String>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6066;
        }// end function

        public function initLivingObjectMessageRequestMessage(param1:uint = 0, param2:Vector.<String> = null, param3:uint = 0) : LivingObjectMessageRequestMessage
        {
            this.msgId = param1;
            this.parameters = param2;
            this.livingObject = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.msgId = 0;
            this.parameters = new Vector.<String>;
            this.livingObject = 0;
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
            this.serializeAs_LivingObjectMessageRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_LivingObjectMessageRequestMessage(param1:IDataOutput) : void
        {
            if (this.msgId < 0)
            {
                throw new Error("Forbidden value (" + this.msgId + ") on element msgId.");
            }
            param1.writeShort(this.msgId);
            param1.writeShort(this.parameters.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.parameters.length)
            {
                
                param1.writeUTF(this.parameters[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            if (this.livingObject < 0 || this.livingObject > 4294967295)
            {
                throw new Error("Forbidden value (" + this.livingObject + ") on element livingObject.");
            }
            param1.writeUnsignedInt(this.livingObject);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_LivingObjectMessageRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_LivingObjectMessageRequestMessage(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            this.msgId = param1.readShort();
            if (this.msgId < 0)
            {
                throw new Error("Forbidden value (" + this.msgId + ") on element of LivingObjectMessageRequestMessage.msgId.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readUTF();
                this.parameters.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            this.livingObject = param1.readUnsignedInt();
            if (this.livingObject < 0 || this.livingObject > 4294967295)
            {
                throw new Error("Forbidden value (" + this.livingObject + ") on element of LivingObjectMessageRequestMessage.livingObject.");
            }
            return;
        }// end function

    }
}
