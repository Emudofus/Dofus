package com.ankamagames.dofus.network.types.game.friend
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.network.utils.*;
    import flash.utils.*;

    public class FriendSpouseOnlineInformations extends FriendSpouseInformations implements INetworkType
    {
        public var mapId:uint = 0;
        public var subAreaId:uint = 0;
        public var inFight:Boolean = false;
        public var followSpouse:Boolean = false;
        public var pvpEnabled:Boolean = false;
        public static const protocolId:uint = 93;

        public function FriendSpouseOnlineInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 93;
        }// end function

        public function initFriendSpouseOnlineInformations(param1:uint = 0, param2:uint = 0, param3:String = "", param4:uint = 0, param5:int = 0, param6:int = 0, param7:EntityLook = null, param8:BasicGuildInformations = null, param9:int = 0, param10:uint = 0, param11:uint = 0, param12:Boolean = false, param13:Boolean = false, param14:Boolean = false) : FriendSpouseOnlineInformations
        {
            super.initFriendSpouseInformations(param1, param2, param3, param4, param5, param6, param7, param8, param9);
            this.mapId = param10;
            this.subAreaId = param11;
            this.inFight = param12;
            this.followSpouse = param13;
            this.pvpEnabled = param14;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.mapId = 0;
            this.subAreaId = 0;
            this.inFight = false;
            this.followSpouse = false;
            this.pvpEnabled = false;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FriendSpouseOnlineInformations(param1);
            return;
        }// end function

        public function serializeAs_FriendSpouseOnlineInformations(param1:IDataOutput) : void
        {
            super.serializeAs_FriendSpouseInformations(param1);
            var _loc_2:uint = 0;
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 0, this.inFight);
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 1, this.followSpouse);
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 2, this.pvpEnabled);
            param1.writeByte(_loc_2);
            if (this.mapId < 0)
            {
                throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
            }
            param1.writeInt(this.mapId);
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
            }
            param1.writeShort(this.subAreaId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FriendSpouseOnlineInformations(param1);
            return;
        }// end function

        public function deserializeAs_FriendSpouseOnlineInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            var _loc_2:* = param1.readByte();
            this.inFight = BooleanByteWrapper.getFlag(_loc_2, 0);
            this.followSpouse = BooleanByteWrapper.getFlag(_loc_2, 1);
            this.pvpEnabled = BooleanByteWrapper.getFlag(_loc_2, 2);
            this.mapId = param1.readInt();
            if (this.mapId < 0)
            {
                throw new Error("Forbidden value (" + this.mapId + ") on element of FriendSpouseOnlineInformations.mapId.");
            }
            this.subAreaId = param1.readShort();
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element of FriendSpouseOnlineInformations.subAreaId.");
            }
            return;
        }// end function

    }
}
