package com.ankamagames.dofus.network.types.game.actions.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FightTemporaryBoostWeaponDamagesEffect extends FightTemporaryBoostEffect implements INetworkType
    {
        public var weaponTypeId:int = 0;
        public static const protocolId:uint = 211;

        public function FightTemporaryBoostWeaponDamagesEffect()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 211;
        }// end function

        public function initFightTemporaryBoostWeaponDamagesEffect(param1:uint = 0, param2:int = 0, param3:int = 0, param4:uint = 1, param5:uint = 0, param6:uint = 0, param7:int = 0, param8:int = 0) : FightTemporaryBoostWeaponDamagesEffect
        {
            super.initFightTemporaryBoostEffect(param1, param2, param3, param4, param5, param6, param7);
            this.weaponTypeId = param8;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.weaponTypeId = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FightTemporaryBoostWeaponDamagesEffect(param1);
            return;
        }// end function

        public function serializeAs_FightTemporaryBoostWeaponDamagesEffect(param1:IDataOutput) : void
        {
            super.serializeAs_FightTemporaryBoostEffect(param1);
            param1.writeShort(this.weaponTypeId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FightTemporaryBoostWeaponDamagesEffect(param1);
            return;
        }// end function

        public function deserializeAs_FightTemporaryBoostWeaponDamagesEffect(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.weaponTypeId = param1.readShort();
            return;
        }// end function

    }
}
