package com.ankamagames.dofus.network.types.game.friend
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FriendSpouseInformations extends Object implements INetworkType
    {
        public var spouseAccountId:uint = 0;
        public var spouseId:uint = 0;
        public var spouseName:String = "";
        public var spouseLevel:uint = 0;
        public var breed:int = 0;
        public var sex:int = 0;
        public var spouseEntityLook:EntityLook;
        public var guildInfo:BasicGuildInformations;
        public var alignmentSide:int = 0;
        public static const protocolId:uint = 77;

        public function FriendSpouseInformations()
        {
            this.spouseEntityLook = new EntityLook();
            this.guildInfo = new BasicGuildInformations();
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 77;
        }// end function

        public function initFriendSpouseInformations(param1:uint = 0, param2:uint = 0, param3:String = "", param4:uint = 0, param5:int = 0, param6:int = 0, param7:EntityLook = null, param8:BasicGuildInformations = null, param9:int = 0) : FriendSpouseInformations
        {
            this.spouseAccountId = param1;
            this.spouseId = param2;
            this.spouseName = param3;
            this.spouseLevel = param4;
            this.breed = param5;
            this.sex = param6;
            this.spouseEntityLook = param7;
            this.guildInfo = param8;
            this.alignmentSide = param9;
            return this;
        }// end function

        public function reset() : void
        {
            this.spouseAccountId = 0;
            this.spouseId = 0;
            this.spouseName = "";
            this.spouseLevel = 0;
            this.breed = 0;
            this.sex = 0;
            this.spouseEntityLook = new EntityLook();
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FriendSpouseInformations(param1);
            return;
        }// end function

        public function serializeAs_FriendSpouseInformations(param1:IDataOutput) : void
        {
            if (this.spouseAccountId < 0)
            {
                throw new Error("Forbidden value (" + this.spouseAccountId + ") on element spouseAccountId.");
            }
            param1.writeInt(this.spouseAccountId);
            if (this.spouseId < 0)
            {
                throw new Error("Forbidden value (" + this.spouseId + ") on element spouseId.");
            }
            param1.writeInt(this.spouseId);
            param1.writeUTF(this.spouseName);
            if (this.spouseLevel < 1 || this.spouseLevel > 200)
            {
                throw new Error("Forbidden value (" + this.spouseLevel + ") on element spouseLevel.");
            }
            param1.writeByte(this.spouseLevel);
            param1.writeByte(this.breed);
            param1.writeByte(this.sex);
            this.spouseEntityLook.serializeAs_EntityLook(param1);
            this.guildInfo.serializeAs_BasicGuildInformations(param1);
            param1.writeByte(this.alignmentSide);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FriendSpouseInformations(param1);
            return;
        }// end function

        public function deserializeAs_FriendSpouseInformations(param1:IDataInput) : void
        {
            this.spouseAccountId = param1.readInt();
            if (this.spouseAccountId < 0)
            {
                throw new Error("Forbidden value (" + this.spouseAccountId + ") on element of FriendSpouseInformations.spouseAccountId.");
            }
            this.spouseId = param1.readInt();
            if (this.spouseId < 0)
            {
                throw new Error("Forbidden value (" + this.spouseId + ") on element of FriendSpouseInformations.spouseId.");
            }
            this.spouseName = param1.readUTF();
            this.spouseLevel = param1.readUnsignedByte();
            if (this.spouseLevel < 1 || this.spouseLevel > 200)
            {
                throw new Error("Forbidden value (" + this.spouseLevel + ") on element of FriendSpouseInformations.spouseLevel.");
            }
            this.breed = param1.readByte();
            this.sex = param1.readByte();
            this.spouseEntityLook = new EntityLook();
            this.spouseEntityLook.deserialize(param1);
            this.guildInfo = new BasicGuildInformations();
            this.guildInfo.deserialize(param1);
            this.alignmentSide = param1.readByte();
            return;
        }// end function

    }
}
