package com.ankamagames.dofus.network.messages.game.guild.tax
{
    import com.ankamagames.dofus.network.types.game.guild.tax.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TaxCollectorAttackedResultMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var deadOrAlive:Boolean = false;
        public var basicInfos:TaxCollectorBasicInformations;
        public static const protocolId:uint = 5635;

        public function TaxCollectorAttackedResultMessage()
        {
            this.basicInfos = new TaxCollectorBasicInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5635;
        }// end function

        public function initTaxCollectorAttackedResultMessage(param1:Boolean = false, param2:TaxCollectorBasicInformations = null) : TaxCollectorAttackedResultMessage
        {
            this.deadOrAlive = param1;
            this.basicInfos = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.deadOrAlive = false;
            this.basicInfos = new TaxCollectorBasicInformations();
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
            this.serializeAs_TaxCollectorAttackedResultMessage(param1);
            return;
        }// end function

        public function serializeAs_TaxCollectorAttackedResultMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.deadOrAlive);
            this.basicInfos.serializeAs_TaxCollectorBasicInformations(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TaxCollectorAttackedResultMessage(param1);
            return;
        }// end function

        public function deserializeAs_TaxCollectorAttackedResultMessage(param1:IDataInput) : void
        {
            this.deadOrAlive = param1.readBoolean();
            this.basicInfos = new TaxCollectorBasicInformations();
            this.basicInfos.deserialize(param1);
            return;
        }// end function

    }
}
