package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyGuestInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class PartyNewGuestMessage extends AbstractPartyEventMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6260;

        private var _isInitialized:Boolean = false;
        public var guest:PartyGuestInformations;

        public function PartyNewGuestMessage()
        {
            this.guest = new PartyGuestInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6260);
        }

        public function initPartyNewGuestMessage(partyId:uint=0, guest:PartyGuestInformations=null):PartyNewGuestMessage
        {
            super.initAbstractPartyEventMessage(partyId);
            this.guest = guest;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.guest = new PartyGuestInformations();
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
            this.serializeAs_PartyNewGuestMessage(output);
        }

        public function serializeAs_PartyNewGuestMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractPartyEventMessage(output);
            this.guest.serializeAs_PartyGuestInformations(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartyNewGuestMessage(input);
        }

        public function deserializeAs_PartyNewGuestMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.guest = new PartyGuestInformations();
            this.guest.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

