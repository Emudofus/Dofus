package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PartyInvitationArenaRequestMessage extends PartyInvitationRequestMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6283;

        private var _isInitialized:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6283);
        }

        public function initPartyInvitationArenaRequestMessage(name:String=""):PartyInvitationArenaRequestMessage
        {
            super.initPartyInvitationRequestMessage(name);
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
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
            this.serializeAs_PartyInvitationArenaRequestMessage(output);
        }

        public function serializeAs_PartyInvitationArenaRequestMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_PartyInvitationRequestMessage(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartyInvitationArenaRequestMessage(input);
        }

        public function deserializeAs_PartyInvitationArenaRequestMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

