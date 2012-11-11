package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayGroupMonsterInformations extends GameRolePlayActorInformations implements INetworkType
    {
        public var staticInfos:GroupMonsterStaticInformations;
        public var ageBonus:int = 0;
        public var lootShare:int = 0;
        public var alignmentSide:int = 0;
        public var keyRingBonus:Boolean = false;
        public static const protocolId:uint = 160;

        public function GameRolePlayGroupMonsterInformations()
        {
            this.staticInfos = new GroupMonsterStaticInformations();
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 160;
        }// end function

        public function initGameRolePlayGroupMonsterInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:GroupMonsterStaticInformations = null, param5:int = 0, param6:int = 0, param7:int = 0, param8:Boolean = false) : GameRolePlayGroupMonsterInformations
        {
            super.initGameRolePlayActorInformations(param1, param2, param3);
            this.staticInfos = param4;
            this.ageBonus = param5;
            this.lootShare = param6;
            this.alignmentSide = param7;
            this.keyRingBonus = param8;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.staticInfos = new GroupMonsterStaticInformations();
            this.lootShare = 0;
            this.alignmentSide = 0;
            this.keyRingBonus = false;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameRolePlayGroupMonsterInformations(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayGroupMonsterInformations(param1:IDataOutput) : void
        {
            super.serializeAs_GameRolePlayActorInformations(param1);
            param1.writeShort(this.staticInfos.getTypeId());
            this.staticInfos.serialize(param1);
            if (this.ageBonus < -1 || this.ageBonus > 1000)
            {
                throw new Error("Forbidden value (" + this.ageBonus + ") on element ageBonus.");
            }
            param1.writeShort(this.ageBonus);
            if (this.lootShare < -1 || this.lootShare > 8)
            {
                throw new Error("Forbidden value (" + this.lootShare + ") on element lootShare.");
            }
            param1.writeByte(this.lootShare);
            param1.writeByte(this.alignmentSide);
            param1.writeBoolean(this.keyRingBonus);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayGroupMonsterInformations(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayGroupMonsterInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            this.staticInfos = ProtocolTypeManager.getInstance(GroupMonsterStaticInformations, _loc_2);
            this.staticInfos.deserialize(param1);
            this.ageBonus = param1.readShort();
            if (this.ageBonus < -1 || this.ageBonus > 1000)
            {
                throw new Error("Forbidden value (" + this.ageBonus + ") on element of GameRolePlayGroupMonsterInformations.ageBonus.");
            }
            this.lootShare = param1.readByte();
            if (this.lootShare < -1 || this.lootShare > 8)
            {
                throw new Error("Forbidden value (" + this.lootShare + ") on element of GameRolePlayGroupMonsterInformations.lootShare.");
            }
            this.alignmentSide = param1.readByte();
            this.keyRingBonus = param1.readBoolean();
            return;
        }// end function

    }
}
