package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class PartyCancelInvitationMessage extends AbstractPartyMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6254;

        private var _isInitialized:Boolean = false;
        public var guestId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6254);
        }

        public function initPartyCancelInvitationMessage(partyId:uint=0, guestId:uint=0):PartyCancelInvitationMessage
        {
            super.initAbstractPartyMessage(partyId);
            this.guestId = guestId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.guestId = 0;
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
            this.serializeAs_PartyCancelInvitationMessage(output);
        }

        public function serializeAs_PartyCancelInvitationMessage(output:IDataOutput):void
        {
            super.serializeAs_AbstractPartyMessage(output);
            if (this.guestId < 0)
            {
                throw (new Error((("Forbidden value (" + this.guestId) + ") on element guestId.")));
            };
            output.writeInt(this.guestId);
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_PartyCancelInvitationMessage(input);
        }

        public function deserializeAs_PartyCancelInvitationMessage(input:IDataInput):void
        {
            super.deserialize(input);
            this.guestId = input.readInt();
            if (this.guestId < 0)
            {
                throw (new Error((("Forbidden value (" + this.guestId) + ") on element of PartyCancelInvitationMessage.guestId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

