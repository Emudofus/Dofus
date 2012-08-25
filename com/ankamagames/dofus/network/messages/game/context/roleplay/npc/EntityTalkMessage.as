package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class EntityTalkMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var entityId:int = 0;
        public var textId:uint = 0;
        public var parameters:Vector.<String>;
        public static const protocolId:uint = 6110;

        public function EntityTalkMessage()
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
            return 6110;
        }// end function

        public function initEntityTalkMessage(param1:int = 0, param2:uint = 0, param3:Vector.<String> = null) : EntityTalkMessage
        {
            this.entityId = param1;
            this.textId = param2;
            this.parameters = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.entityId = 0;
            this.textId = 0;
            this.parameters = new Vector.<String>;
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
            this.serializeAs_EntityTalkMessage(param1);
            return;
        }// end function

        public function serializeAs_EntityTalkMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.entityId);
            if (this.textId < 0)
            {
                throw new Error("Forbidden value (" + this.textId + ") on element textId.");
            }
            param1.writeShort(this.textId);
            param1.writeShort(this.parameters.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.parameters.length)
            {
                
                param1.writeUTF(this.parameters[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_EntityTalkMessage(param1);
            return;
        }// end function

        public function deserializeAs_EntityTalkMessage(param1:IDataInput) : void
        {
            var _loc_4:String = null;
            this.entityId = param1.readInt();
            this.textId = param1.readShort();
            if (this.textId < 0)
            {
                throw new Error("Forbidden value (" + this.textId + ") on element of EntityTalkMessage.textId.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readUTF();
                this.parameters.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
