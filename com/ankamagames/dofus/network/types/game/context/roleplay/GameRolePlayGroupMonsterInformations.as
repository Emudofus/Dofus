package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayGroupMonsterInformations extends GameRolePlayActorInformations implements INetworkType
    {
        public var mainCreatureGenericId:int = 0;
        public var mainCreatureGrade:uint = 0;
        public var underlings:Vector.<MonsterInGroupInformations>;
        public var ageBonus:int = 0;
        public var alignmentSide:int = 0;
        public var keyRingBonus:Boolean = false;
        public static const protocolId:uint = 160;

        public function GameRolePlayGroupMonsterInformations()
        {
            this.underlings = new Vector.<MonsterInGroupInformations>;
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 160;
        }// end function

        public function initGameRolePlayGroupMonsterInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:int = 0, param5:uint = 0, param6:Vector.<MonsterInGroupInformations> = null, param7:int = 0, param8:int = 0, param9:Boolean = false) : GameRolePlayGroupMonsterInformations
        {
            super.initGameRolePlayActorInformations(param1, param2, param3);
            this.mainCreatureGenericId = param4;
            this.mainCreatureGrade = param5;
            this.underlings = param6;
            this.ageBonus = param7;
            this.alignmentSide = param8;
            this.keyRingBonus = param9;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.mainCreatureGenericId = 0;
            this.mainCreatureGrade = 0;
            this.underlings = new Vector.<MonsterInGroupInformations>;
            this.ageBonus = 0;
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
            param1.writeInt(this.mainCreatureGenericId);
            if (this.mainCreatureGrade < 0)
            {
                throw new Error("Forbidden value (" + this.mainCreatureGrade + ") on element mainCreatureGrade.");
            }
            param1.writeByte(this.mainCreatureGrade);
            param1.writeShort(this.underlings.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.underlings.length)
            {
                
                (this.underlings[_loc_2] as MonsterInGroupInformations).serializeAs_MonsterInGroupInformations(param1);
                _loc_2 = _loc_2 + 1;
            }
            if (this.ageBonus < -1 || this.ageBonus > 1000)
            {
                throw new Error("Forbidden value (" + this.ageBonus + ") on element ageBonus.");
            }
            param1.writeShort(this.ageBonus);
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
            var _loc_4:MonsterInGroupInformations = null;
            super.deserialize(param1);
            this.mainCreatureGenericId = param1.readInt();
            this.mainCreatureGrade = param1.readByte();
            if (this.mainCreatureGrade < 0)
            {
                throw new Error("Forbidden value (" + this.mainCreatureGrade + ") on element of GameRolePlayGroupMonsterInformations.mainCreatureGrade.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new MonsterInGroupInformations();
                _loc_4.deserialize(param1);
                this.underlings.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            this.ageBonus = param1.readShort();
            if (this.ageBonus < -1 || this.ageBonus > 1000)
            {
                throw new Error("Forbidden value (" + this.ageBonus + ") on element of GameRolePlayGroupMonsterInformations.ageBonus.");
            }
            this.alignmentSide = param1.readByte();
            this.keyRingBonus = param1.readBoolean();
            return;
        }// end function

    }
}
