package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class PartyNameUpdateMessage extends AbstractPartyMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6502;

        private var _isInitialized:Boolean = false;
        public var partyName:String = "";


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6502);
        }

        public function initPartyNameUpdateMessage(partyId:uint=0, partyName:String=""):PartyNameUpdateMessage
        {
            super.initAbstractPartyMessage(partyId);
            this.partyName = partyName;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.partyName = "";
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_PartyNameUpdateMessage(output);
        }

        public function serializeAs_PartyNameUpdateMessage(output:IDataOutput):void
        {
            super.serializeAs_AbstractPartyMessage(output);
            output.writeUTF(this.partyName);
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_PartyNameUpdateMessage(input);
        }

        public function deserializeAs_PartyNameUpdateMessage(input:IDataInput):void
        {
            super.deserialize(input);
            this.partyName = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

