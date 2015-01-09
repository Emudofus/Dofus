package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PartyInvitationDungeonRequestMessage extends PartyInvitationRequestMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6245;

        private var _isInitialized:Boolean = false;
        public var dungeonId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6245);
        }

        public function initPartyInvitationDungeonRequestMessage(name:String="", dungeonId:uint=0):PartyInvitationDungeonRequestMessage
        {
            super.initPartyInvitationRequestMessage(name);
            this.dungeonId = dungeonId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.dungeonId = 0;
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
            this.serializeAs_PartyInvitationDungeonRequestMessage(output);
        }

        public function serializeAs_PartyInvitationDungeonRequestMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_PartyInvitationRequestMessage(output);
            if (this.dungeonId < 0)
            {
                throw (new Error((("Forbidden value (" + this.dungeonId) + ") on element dungeonId.")));
            };
            output.writeVarShort(this.dungeonId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartyInvitationDungeonRequestMessage(input);
        }

        public function deserializeAs_PartyInvitationDungeonRequestMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.dungeonId = input.readVarUhShort();
            if (this.dungeonId < 0)
            {
                throw (new Error((("Forbidden value (" + this.dungeonId) + ") on element of PartyInvitationDungeonRequestMessage.dungeonId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

