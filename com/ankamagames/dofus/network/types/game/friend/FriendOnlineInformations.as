package com.ankamagames.dofus.network.types.game.friend
{
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FriendOnlineInformations extends FriendInformations implements INetworkType
    {
        public var playerName:String = "";
        public var level:uint = 0;
        public var alignmentSide:int = 0;
        public var breed:int = 0;
        public var sex:Boolean = false;
        public var guildInfo:BasicGuildInformations;
        public var moodSmileyId:int = 0;
        public static const protocolId:uint = 92;

        public function FriendOnlineInformations()
        {
            this.guildInfo = new BasicGuildInformations();
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 92;
        }// end function

        public function initFriendOnlineInformations(param1:uint = 0, param2:String = "", param3:uint = 99, param4:uint = 0, param5:String = "", param6:uint = 0, param7:int = 0, param8:int = 0, param9:Boolean = false, param10:BasicGuildInformations = null, param11:int = 0) : FriendOnlineInformations
        {
            super.initFriendInformations(param1, param2, param3, param4);
            this.playerName = param5;
            this.level = param6;
            this.alignmentSide = param7;
            this.breed = param8;
            this.sex = param9;
            this.guildInfo = param10;
            this.moodSmileyId = param11;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.playerName = "";
            this.level = 0;
            this.alignmentSide = 0;
            this.breed = 0;
            this.sex = false;
            this.guildInfo = new BasicGuildInformations();
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FriendOnlineInformations(param1);
            return;
        }// end function

        public function serializeAs_FriendOnlineInformations(param1:IDataOutput) : void
        {
            super.serializeAs_FriendInformations(param1);
            param1.writeUTF(this.playerName);
            if (this.level < 0 || this.level > 200)
            {
                throw new Error("Forbidden value (" + this.level + ") on element level.");
            }
            param1.writeShort(this.level);
            param1.writeByte(this.alignmentSide);
            param1.writeByte(this.breed);
            param1.writeBoolean(this.sex);
            this.guildInfo.serializeAs_BasicGuildInformations(param1);
            param1.writeByte(this.moodSmileyId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FriendOnlineInformations(param1);
            return;
        }// end function

        public function deserializeAs_FriendOnlineInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.playerName = param1.readUTF();
            this.level = param1.readShort();
            if (this.level < 0 || this.level > 200)
            {
                throw new Error("Forbidden value (" + this.level + ") on element of FriendOnlineInformations.level.");
            }
            this.alignmentSide = param1.readByte();
            this.breed = param1.readByte();
            if (this.breed < PlayableBreedEnum.Feca || this.breed > PlayableBreedEnum.Steamer)
            {
                throw new Error("Forbidden value (" + this.breed + ") on element of FriendOnlineInformations.breed.");
            }
            this.sex = param1.readBoolean();
            this.guildInfo = new BasicGuildInformations();
            this.guildInfo.deserialize(param1);
            this.moodSmileyId = param1.readByte();
            return;
        }// end function

    }
}
