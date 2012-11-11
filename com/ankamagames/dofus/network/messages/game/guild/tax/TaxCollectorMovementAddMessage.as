package com.ankamagames.dofus.network.messages.game.guild.tax
{
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.guild.tax.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TaxCollectorMovementAddMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var informations:TaxCollectorInformations;
        public static const protocolId:uint = 5917;

        public function TaxCollectorMovementAddMessage()
        {
            this.informations = new TaxCollectorInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5917;
        }// end function

        public function initTaxCollectorMovementAddMessage(param1:TaxCollectorInformations = null) : TaxCollectorMovementAddMessage
        {
            this.informations = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.informations = new TaxCollectorInformations();
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
            this.serializeAs_TaxCollectorMovementAddMessage(param1);
            return;
        }// end function

        public function serializeAs_TaxCollectorMovementAddMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.informations.getTypeId());
            this.informations.serialize(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TaxCollectorMovementAddMessage(param1);
            return;
        }// end function

        public function deserializeAs_TaxCollectorMovementAddMessage(param1:IDataInput) : void
        {
            var _loc_2:* = param1.readUnsignedShort();
            this.informations = ProtocolTypeManager.getInstance(TaxCollectorInformations, _loc_2);
            this.informations.deserialize(param1);
            return;
        }// end function

    }
}
