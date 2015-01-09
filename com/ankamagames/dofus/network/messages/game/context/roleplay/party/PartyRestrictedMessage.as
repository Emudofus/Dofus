package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PartyRestrictedMessage extends AbstractPartyMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6175;

        private var _isInitialized:Boolean = false;
        public var restricted:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6175);
        }

        public function initPartyRestrictedMessage(partyId:uint=0, restricted:Boolean=false):PartyRestrictedMessage
        {
            super.initAbstractPartyMessage(partyId);
            this.restricted = restricted;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.restricted = false;
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
            this.serializeAs_PartyRestrictedMessage(output);
        }

        public function serializeAs_PartyRestrictedMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractPartyMessage(output);
            output.writeBoolean(this.restricted);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartyRestrictedMessage(input);
        }

        public function deserializeAs_PartyRestrictedMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.restricted = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

