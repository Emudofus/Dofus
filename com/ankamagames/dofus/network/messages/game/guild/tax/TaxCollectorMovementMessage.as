package com.ankamagames.dofus.network.messages.game.guild.tax
{
    import com.ankamagames.dofus.network.types.game.guild.tax.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TaxCollectorMovementMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var hireOrFire:Boolean = false;
        public var basicInfos:TaxCollectorBasicInformations;
        public var playerName:String = "";
        public static const protocolId:uint = 5633;

        public function TaxCollectorMovementMessage()
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
            return 5633;
        }// end function

        public function initTaxCollectorMovementMessage(param1:Boolean = false, param2:TaxCollectorBasicInformations = null, param3:String = "") : TaxCollectorMovementMessage
        {
            this.hireOrFire = param1;
            this.basicInfos = param2;
            this.playerName = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.hireOrFire = false;
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
            this.serializeAs_TaxCollectorMovementMessage(param1);
            return;
        }// end function

        public function serializeAs_TaxCollectorMovementMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.hireOrFire);
            this.basicInfos.serializeAs_TaxCollectorBasicInformations(param1);
            param1.writeUTF(this.playerName);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TaxCollectorMovementMessage(param1);
            return;
        }// end function

        public function deserializeAs_TaxCollectorMovementMessage(param1:IDataInput) : void
        {
            this.hireOrFire = param1.readBoolean();
            this.basicInfos = new TaxCollectorBasicInformations();
            this.basicInfos.deserialize(param1);
            this.playerName = param1.readUTF();
            return;
        }// end function

    }
}
