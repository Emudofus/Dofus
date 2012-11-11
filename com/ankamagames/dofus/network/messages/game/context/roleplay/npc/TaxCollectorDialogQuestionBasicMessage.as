package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TaxCollectorDialogQuestionBasicMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var guildInfo:BasicGuildInformations;
        public static const protocolId:uint = 5619;

        public function TaxCollectorDialogQuestionBasicMessage()
        {
            this.guildInfo = new BasicGuildInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5619;
        }// end function

        public function initTaxCollectorDialogQuestionBasicMessage(param1:BasicGuildInformations = null) : TaxCollectorDialogQuestionBasicMessage
        {
            this.guildInfo = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.guildInfo = new BasicGuildInformations();
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
            this.serializeAs_TaxCollectorDialogQuestionBasicMessage(param1);
            return;
        }// end function

        public function serializeAs_TaxCollectorDialogQuestionBasicMessage(param1:IDataOutput) : void
        {
            this.guildInfo.serializeAs_BasicGuildInformations(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TaxCollectorDialogQuestionBasicMessage(param1);
            return;
        }// end function

        public function deserializeAs_TaxCollectorDialogQuestionBasicMessage(param1:IDataInput) : void
        {
            this.guildInfo = new BasicGuildInformations();
            this.guildInfo.deserialize(param1);
            return;
        }// end function

    }
}
