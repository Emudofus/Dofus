package com.ankamagames.dofus.network.types.game.guild
{
    import com.ankamagames.dofus.network.types.game.character.CharacterMinimalInformations;
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;

    public class GuildMember extends CharacterMinimalInformations implements INetworkType 
    {

        public static const protocolId:uint = 88;

        public var breed:int = 0;
        public var sex:Boolean = false;
        public var rank:uint = 0;
        public var givenExperience:Number = 0;
        public var experienceGivenPercent:uint = 0;
        public var rights:uint = 0;
        public var connected:uint = 99;
        public var alignmentSide:int = 0;
        public var hoursSinceLastConnection:uint = 0;
        public var moodSmileyId:int = 0;
        public var accountId:uint = 0;
        public var achievementPoints:int = 0;
        public var status:PlayerStatus;

        public function GuildMember()
        {
            this.status = new PlayerStatus();
            super();
        }

        override public function getTypeId():uint
        {
            return (88);
        }

        public function initGuildMember(id:uint=0, level:uint=0, name:String="", breed:int=0, sex:Boolean=false, rank:uint=0, givenExperience:Number=0, experienceGivenPercent:uint=0, rights:uint=0, connected:uint=99, alignmentSide:int=0, hoursSinceLastConnection:uint=0, moodSmileyId:int=0, accountId:uint=0, achievementPoints:int=0, status:PlayerStatus=null):GuildMember
        {
            super.initCharacterMinimalInformations(id, level, name);
            this.breed = breed;
            this.sex = sex;
            this.rank = rank;
            this.givenExperience = givenExperience;
            this.experienceGivenPercent = experienceGivenPercent;
            this.rights = rights;
            this.connected = connected;
            this.alignmentSide = alignmentSide;
            this.hoursSinceLastConnection = hoursSinceLastConnection;
            this.moodSmileyId = moodSmileyId;
            this.accountId = accountId;
            this.achievementPoints = achievementPoints;
            this.status = status;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.breed = 0;
            this.sex = false;
            this.rank = 0;
            this.givenExperience = 0;
            this.experienceGivenPercent = 0;
            this.rights = 0;
            this.connected = 99;
            this.alignmentSide = 0;
            this.hoursSinceLastConnection = 0;
            this.moodSmileyId = 0;
            this.accountId = 0;
            this.achievementPoints = 0;
            this.status = new PlayerStatus();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GuildMember(output);
        }

        public function serializeAs_GuildMember(output:ICustomDataOutput):void
        {
            super.serializeAs_CharacterMinimalInformations(output);
            output.writeByte(this.breed);
            output.writeBoolean(this.sex);
            if (this.rank < 0)
            {
                throw (new Error((("Forbidden value (" + this.rank) + ") on element rank.")));
            };
            output.writeVarShort(this.rank);
            if ((((this.givenExperience < 0)) || ((this.givenExperience > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.givenExperience) + ") on element givenExperience.")));
            };
            output.writeVarLong(this.givenExperience);
            if ((((this.experienceGivenPercent < 0)) || ((this.experienceGivenPercent > 100))))
            {
                throw (new Error((("Forbidden value (" + this.experienceGivenPercent) + ") on element experienceGivenPercent.")));
            };
            output.writeByte(this.experienceGivenPercent);
            if (this.rights < 0)
            {
                throw (new Error((("Forbidden value (" + this.rights) + ") on element rights.")));
            };
            output.writeVarInt(this.rights);
            output.writeByte(this.connected);
            output.writeByte(this.alignmentSide);
            if ((((this.hoursSinceLastConnection < 0)) || ((this.hoursSinceLastConnection > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.hoursSinceLastConnection) + ") on element hoursSinceLastConnection.")));
            };
            output.writeShort(this.hoursSinceLastConnection);
            output.writeByte(this.moodSmileyId);
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element accountId.")));
            };
            output.writeInt(this.accountId);
            output.writeInt(this.achievementPoints);
            output.writeShort(this.status.getTypeId());
            this.status.serialize(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildMember(input);
        }

        public function deserializeAs_GuildMember(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.breed = input.readByte();
            this.sex = input.readBoolean();
            this.rank = input.readVarUhShort();
            if (this.rank < 0)
            {
                throw (new Error((("Forbidden value (" + this.rank) + ") on element of GuildMember.rank.")));
            };
            this.givenExperience = input.readVarUhLong();
            if ((((this.givenExperience < 0)) || ((this.givenExperience > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.givenExperience) + ") on element of GuildMember.givenExperience.")));
            };
            this.experienceGivenPercent = input.readByte();
            if ((((this.experienceGivenPercent < 0)) || ((this.experienceGivenPercent > 100))))
            {
                throw (new Error((("Forbidden value (" + this.experienceGivenPercent) + ") on element of GuildMember.experienceGivenPercent.")));
            };
            this.rights = input.readVarUhInt();
            if (this.rights < 0)
            {
                throw (new Error((("Forbidden value (" + this.rights) + ") on element of GuildMember.rights.")));
            };
            this.connected = input.readByte();
            if (this.connected < 0)
            {
                throw (new Error((("Forbidden value (" + this.connected) + ") on element of GuildMember.connected.")));
            };
            this.alignmentSide = input.readByte();
            this.hoursSinceLastConnection = input.readUnsignedShort();
            if ((((this.hoursSinceLastConnection < 0)) || ((this.hoursSinceLastConnection > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.hoursSinceLastConnection) + ") on element of GuildMember.hoursSinceLastConnection.")));
            };
            this.moodSmileyId = input.readByte();
            this.accountId = input.readInt();
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element of GuildMember.accountId.")));
            };
            this.achievementPoints = input.readInt();
            var _id13:uint = input.readUnsignedShort();
            this.status = ProtocolTypeManager.getInstance(PlayerStatus, _id13);
            this.status.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.types.game.guild

