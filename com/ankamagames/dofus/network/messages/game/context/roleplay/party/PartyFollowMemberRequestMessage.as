package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class PartyFollowMemberRequestMessage extends AbstractPartyMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5577;

        private var _isInitialized:Boolean = false;
        public var playerId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5577);
        }

        public function initPartyFollowMemberRequestMessage(partyId:uint=0, playerId:uint=0):PartyFollowMemberRequestMessage
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
            this.serializeAs_PartyFollowMemberRequestMessage(output);
        }

        public function serializeAs_PartyFollowMemberRequestMessage(output:IDataOutput):void
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
            this.deserializeAs_PartyFollowMemberRequestMessage(input);
        }

        public function deserializeAs_PartyFollowMemberRequestMessage(input:IDataInput):void
        {
            super.deserialize(input);
            this.playerId = input.readInt();
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element of PartyFollowMemberRequestMessage.playerId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

