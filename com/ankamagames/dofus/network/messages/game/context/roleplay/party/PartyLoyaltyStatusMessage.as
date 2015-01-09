package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PartyLoyaltyStatusMessage extends AbstractPartyMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6270;

        private var _isInitialized:Boolean = false;
        public var loyal:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6270);
        }

        public function initPartyLoyaltyStatusMessage(partyId:uint=0, loyal:Boolean=false):PartyLoyaltyStatusMessage
        {
            super.initAbstractPartyMessage(partyId);
            this.loyal = loyal;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.loyal = false;
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
            this.serializeAs_PartyLoyaltyStatusMessage(output);
        }

        public function serializeAs_PartyLoyaltyStatusMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractPartyMessage(output);
            output.writeBoolean(this.loyal);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartyLoyaltyStatusMessage(input);
        }

        public function deserializeAs_PartyLoyaltyStatusMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.loyal = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

