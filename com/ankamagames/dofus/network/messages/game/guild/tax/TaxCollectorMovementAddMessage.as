package com.ankamagames.dofus.network.messages.game.guild.tax
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;

    [Trusted]
    public class TaxCollectorMovementAddMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5917;

        private var _isInitialized:Boolean = false;
        public var informations:TaxCollectorInformations;

        public function TaxCollectorMovementAddMessage()
        {
            this.informations = new TaxCollectorInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5917);
        }

        public function initTaxCollectorMovementAddMessage(informations:TaxCollectorInformations=null):TaxCollectorMovementAddMessage
        {
            this.informations = informations;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.informations = new TaxCollectorInformations();
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_TaxCollectorMovementAddMessage(output);
        }

        public function serializeAs_TaxCollectorMovementAddMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.informations.getTypeId());
            this.informations.serialize(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TaxCollectorMovementAddMessage(input);
        }

        public function deserializeAs_TaxCollectorMovementAddMessage(input:ICustomDataInput):void
        {
            var _id1:uint = input.readUnsignedShort();
            this.informations = ProtocolTypeManager.getInstance(TaxCollectorInformations, _id1);
            this.informations.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild.tax

