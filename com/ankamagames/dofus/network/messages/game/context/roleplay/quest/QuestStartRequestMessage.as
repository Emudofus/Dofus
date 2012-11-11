package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class QuestStartRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var questId:uint = 0;
        public static const protocolId:uint = 5643;

        public function QuestStartRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5643;
        }// end function

        public function initQuestStartRequestMessage(param1:uint = 0) : QuestStartRequestMessage
        {
            this.questId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.questId = 0;
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
            this.serializeAs_QuestStartRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_QuestStartRequestMessage(param1:IDataOutput) : void
        {
            if (this.questId < 0 || this.questId > 65535)
            {
                throw new Error("Forbidden value (" + this.questId + ") on element questId.");
            }
            param1.writeShort(this.questId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_QuestStartRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_QuestStartRequestMessage(param1:IDataInput) : void
        {
            this.questId = param1.readUnsignedShort();
            if (this.questId < 0 || this.questId > 65535)
            {
                throw new Error("Forbidden value (" + this.questId + ") on element of QuestStartRequestMessage.questId.");
            }
            return;
        }// end function

    }
}
