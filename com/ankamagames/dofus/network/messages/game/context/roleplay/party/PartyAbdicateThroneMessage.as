package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class PartyAbdicateThroneMessage extends AbstractPartyMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6080;

        private var _isInitialized:Boolean = false;
        public var playerId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6080);
        }

        public function initPartyAbdicateThroneMessage(partyId:uint=0, playerId:uint=0):PartyAbdicateThroneMessage
        {
            super.initAbstractPartyMessage(partyId);
            this.playerId = playerId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.playerId = 0;
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
            this.serializeAs_PartyAbdicateThroneMessage(output);
        }

        public function serializeAs_PartyAbdicateThroneMessage(output:IDataOutput):void
        {
            super.serializeAs_AbstractPartyMessage(output);
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element playerId.")));
            };
            output.writeInt(this.playerId);
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_PartyAbdicateThroneMessage(input);
        }

        public function deserializeAs_PartyAbdicateThroneMessage(input:IDataInput):void
        {
            super.deserialize(input);
            this.playerId = input.readInt();
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element of PartyAbdicateThroneMessage.playerId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

