package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PartyFollowStatusUpdateMessage extends AbstractPartyMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5581;

        private var _isInitialized:Boolean = false;
        public var success:Boolean = false;
        public var followedId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5581);
        }

        public function initPartyFollowStatusUpdateMessage(partyId:uint=0, success:Boolean=false, followedId:uint=0):PartyFollowStatusUpdateMessage
        {
            super.initAbstractPartyMessage(partyId);
            this.success = success;
            this.followedId = followedId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.success = false;
            this.followedId = 0;
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_PartyFollowStatusUpdateMessage(output);
        }

        public function serializeAs_PartyFollowStatusUpdateMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractPartyMessage(output);
            output.writeBoolean(this.success);
            if (this.followedId < 0)
            {
                throw (new Error((("Forbidden value (" + this.followedId) + ") on element followedId.")));
            };
            output.writeVarInt(this.followedId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartyFollowStatusUpdateMessage(input);
        }

        public function deserializeAs_PartyFollowStatusUpdateMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.success = input.readBoolean();
            this.followedId = input.readVarUhInt();
            if (this.followedId < 0)
            {
                throw (new Error((("Forbidden value (" + this.followedId) + ") on element of PartyFollowStatusUpdateMessage.followedId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

