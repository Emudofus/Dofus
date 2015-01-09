package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class PartyKickedByMessage extends AbstractPartyMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5590;

        private var _isInitialized:Boolean = false;
        public var kickerId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5590);
        }

        public function initPartyKickedByMessage(partyId:uint=0, kickerId:uint=0):PartyKickedByMessage
        {
            super.initAbstractPartyMessage(partyId);
            this.kickerId = kickerId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.kickerId = 0;
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
            this.serializeAs_PartyKickedByMessage(output);
        }

        public function serializeAs_PartyKickedByMessage(output:IDataOutput):void
        {
            super.serializeAs_AbstractPartyMessage(output);
            if (this.kickerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.kickerId) + ") on element kickerId.")));
            };
            output.writeInt(this.kickerId);
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_PartyKickedByMessage(input);
        }

        public function deserializeAs_PartyKickedByMessage(input:IDataInput):void
        {
            super.deserialize(input);
            this.kickerId = input.readInt();
            if (this.kickerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.kickerId) + ") on element of PartyKickedByMessage.kickerId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

