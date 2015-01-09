package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.MapCoordinatesExtended;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PartyMemberInFightMessage extends AbstractPartyMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6342;

        private var _isInitialized:Boolean = false;
        public var reason:uint = 0;
        public var memberId:uint = 0;
        public var memberAccountId:uint = 0;
        public var memberName:String = "";
        public var fightId:int = 0;
        public var fightMap:MapCoordinatesExtended;
        public var secondsBeforeFightStart:int = 0;

        public function PartyMemberInFightMessage()
        {
            this.fightMap = new MapCoordinatesExtended();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6342);
        }

        public function initPartyMemberInFightMessage(partyId:uint=0, reason:uint=0, memberId:uint=0, memberAccountId:uint=0, memberName:String="", fightId:int=0, fightMap:MapCoordinatesExtended=null, secondsBeforeFightStart:int=0):PartyMemberInFightMessage
        {
            super.initAbstractPartyMessage(partyId);
            this.reason = reason;
            this.memberId = memberId;
            this.memberAccountId = memberAccountId;
            this.memberName = memberName;
            this.fightId = fightId;
            this.fightMap = fightMap;
            this.secondsBeforeFightStart = secondsBeforeFightStart;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.reason = 0;
            this.memberId = 0;
            this.memberAccountId = 0;
            this.memberName = "";
            this.fightId = 0;
            this.fightMap = new MapCoordinatesExtended();
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
            this.serializeAs_PartyMemberInFightMessage(output);
        }

        public function serializeAs_PartyMemberInFightMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractPartyMessage(output);
            output.writeByte(this.reason);
            if (this.memberId < 0)
            {
                throw (new Error((("Forbidden value (" + this.memberId) + ") on element memberId.")));
            };
            output.writeVarInt(this.memberId);
            if (this.memberAccountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.memberAccountId) + ") on element memberAccountId.")));
            };
            output.writeInt(this.memberAccountId);
            output.writeUTF(this.memberName);
            output.writeInt(this.fightId);
            this.fightMap.serializeAs_MapCoordinatesExtended(output);
            output.writeVarShort(this.secondsBeforeFightStart);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartyMemberInFightMessage(input);
        }

        public function deserializeAs_PartyMemberInFightMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.reason = input.readByte();
            if (this.reason < 0)
            {
                throw (new Error((("Forbidden value (" + this.reason) + ") on element of PartyMemberInFightMessage.reason.")));
            };
            this.memberId = input.readVarUhInt();
            if (this.memberId < 0)
            {
                throw (new Error((("Forbidden value (" + this.memberId) + ") on element of PartyMemberInFightMessage.memberId.")));
            };
            this.memberAccountId = input.readInt();
            if (this.memberAccountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.memberAccountId) + ") on element of PartyMemberInFightMessage.memberAccountId.")));
            };
            this.memberName = input.readUTF();
            this.fightId = input.readInt();
            this.fightMap = new MapCoordinatesExtended();
            this.fightMap.deserialize(input);
            this.secondsBeforeFightStart = input.readVarShort();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

