package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class NpcGenericActionRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var npcId:int = 0;
        public var npcActionId:uint = 0;
        public var npcMapId:int = 0;
        public static const protocolId:uint = 5898;

        public function NpcGenericActionRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5898;
        }// end function

        public function initNpcGenericActionRequestMessage(param1:int = 0, param2:uint = 0, param3:int = 0) : NpcGenericActionRequestMessage
        {
            this.npcId = param1;
            this.npcActionId = param2;
            this.npcMapId = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.npcId = 0;
            this.npcActionId = 0;
            this.npcMapId = 0;
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
            this.serializeAs_NpcGenericActionRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_NpcGenericActionRequestMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.npcId);
            if (this.npcActionId < 0)
            {
                throw new Error("Forbidden value (" + this.npcActionId + ") on element npcActionId.");
            }
            param1.writeByte(this.npcActionId);
            param1.writeInt(this.npcMapId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_NpcGenericActionRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_NpcGenericActionRequestMessage(param1:IDataInput) : void
        {
            this.npcId = param1.readInt();
            this.npcActionId = param1.readByte();
            if (this.npcActionId < 0)
            {
                throw new Error("Forbidden value (" + this.npcActionId + ") on element of NpcGenericActionRequestMessage.npcActionId.");
            }
            this.npcMapId = param1.readInt();
            return;
        }// end function

    }
}
