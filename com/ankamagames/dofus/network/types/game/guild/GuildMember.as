package com.ankamagames.dofus.network.types.game.guild
{
    import com.ankamagames.dofus.network.types.game.character.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildMember extends CharacterMinimalInformations implements INetworkType
    {
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
        public static const protocolId:uint = 88;

        public function GuildMember()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 88;
        }// end function

        public function initGuildMember(param1:uint = 0, param2:uint = 0, param3:String = "", param4:int = 0, param5:Boolean = false, param6:uint = 0, param7:Number = 0, param8:uint = 0, param9:uint = 0, param10:uint = 99, param11:int = 0, param12:uint = 0, param13:int = 0) : GuildMember
        {
            super.initCharacterMinimalInformations(param1, param2, param3);
            this.breed = param4;
            this.sex = param5;
            this.rank = param6;
            this.givenExperience = param7;
            this.experienceGivenPercent = param8;
            this.rights = param9;
            this.connected = param10;
            this.alignmentSide = param11;
            this.hoursSinceLastConnection = param12;
            this.moodSmileyId = param13;
            return this;
        }// end function

        override public function reset() : void
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
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GuildMember(param1);
            return;
        }// end function

        public function serializeAs_GuildMember(param1:IDataOutput) : void
        {
            super.serializeAs_CharacterMinimalInformations(param1);
            param1.writeByte(this.breed);
            param1.writeBoolean(this.sex);
            if (this.rank < 0)
            {
                throw new Error("Forbidden value (" + this.rank + ") on element rank.");
            }
            param1.writeShort(this.rank);
            if (this.givenExperience < 0)
            {
                throw new Error("Forbidden value (" + this.givenExperience + ") on element givenExperience.");
            }
            param1.writeDouble(this.givenExperience);
            if (this.experienceGivenPercent < 0 || this.experienceGivenPercent > 100)
            {
                throw new Error("Forbidden value (" + this.experienceGivenPercent + ") on element experienceGivenPercent.");
            }
            param1.writeByte(this.experienceGivenPercent);
            if (this.rights < 0 || this.rights > 4294967295)
            {
                throw new Error("Forbidden value (" + this.rights + ") on element rights.");
            }
            param1.writeUnsignedInt(this.rights);
            param1.writeByte(this.connected);
            param1.writeByte(this.alignmentSide);
            if (this.hoursSinceLastConnection < 0 || this.hoursSinceLastConnection > 65535)
            {
                throw new Error("Forbidden value (" + this.hoursSinceLastConnection + ") on element hoursSinceLastConnection.");
            }
            param1.writeShort(this.hoursSinceLastConnection);
            param1.writeByte(this.moodSmileyId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildMember(param1);
            return;
        }// end function

        public function deserializeAs_GuildMember(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.breed = param1.readByte();
            this.sex = param1.readBoolean();
            this.rank = param1.readShort();
            if (this.rank < 0)
            {
                throw new Error("Forbidden value (" + this.rank + ") on element of GuildMember.rank.");
            }
            this.givenExperience = param1.readDouble();
            if (this.givenExperience < 0)
            {
                throw new Error("Forbidden value (" + this.givenExperience + ") on element of GuildMember.givenExperience.");
            }
            this.experienceGivenPercent = param1.readByte();
            if (this.experienceGivenPercent < 0 || this.experienceGivenPercent > 100)
            {
                throw new Error("Forbidden value (" + this.experienceGivenPercent + ") on element of GuildMember.experienceGivenPercent.");
            }
            this.rights = param1.readUnsignedInt();
            if (this.rights < 0 || this.rights > 4294967295)
            {
                throw new Error("Forbidden value (" + this.rights + ") on element of GuildMember.rights.");
            }
            this.connected = param1.readByte();
            if (this.connected < 0)
            {
                throw new Error("Forbidden value (" + this.connected + ") on element of GuildMember.connected.");
            }
            this.alignmentSide = param1.readByte();
            this.hoursSinceLastConnection = param1.readUnsignedShort();
            if (this.hoursSinceLastConnection < 0 || this.hoursSinceLastConnection > 65535)
            {
                throw new Error("Forbidden value (" + this.hoursSinceLastConnection + ") on element of GuildMember.hoursSinceLastConnection.");
            }
            this.moodSmileyId = param1.readByte();
            return;
        }// end function

    }
}
