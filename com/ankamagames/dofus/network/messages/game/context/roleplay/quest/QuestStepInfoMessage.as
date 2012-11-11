package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.quest.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class QuestStepInfoMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var infos:QuestActiveInformations;
        public static const protocolId:uint = 5625;

        public function QuestStepInfoMessage()
        {
            this.infos = new QuestActiveInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5625;
        }// end function

        public function initQuestStepInfoMessage(param1:QuestActiveInformations = null) : QuestStepInfoMessage
        {
            this.infos = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.infos = new QuestActiveInformations();
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
            this.serializeAs_QuestStepInfoMessage(param1);
            return;
        }// end function

        public function serializeAs_QuestStepInfoMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.infos.getTypeId());
            this.infos.serialize(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_QuestStepInfoMessage(param1);
            return;
        }// end function

        public function deserializeAs_QuestStepInfoMessage(param1:IDataInput) : void
        {
            var _loc_2:* = param1.readUnsignedShort();
            this.infos = ProtocolTypeManager.getInstance(QuestActiveInformations, _loc_2);
            this.infos.deserialize(param1);
            return;
        }// end function

    }
}
