package com.ankamagames.dofus.network.types.game.actions.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FightTemporarySpellImmunityEffect extends AbstractFightDispellableEffect implements INetworkType
    {
        public var immuneSpellId:int = 0;
        public static const protocolId:uint = 366;

        public function FightTemporarySpellImmunityEffect()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 366;
        }// end function

        public function initFightTemporarySpellImmunityEffect(param1:uint = 0, param2:int = 0, param3:int = 0, param4:uint = 1, param5:uint = 0, param6:uint = 0, param7:int = 0) : FightTemporarySpellImmunityEffect
        {
            super.initAbstractFightDispellableEffect(param1, param2, param3, param4, param5, param6);
            this.immuneSpellId = param7;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.immuneSpellId = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FightTemporarySpellImmunityEffect(param1);
            return;
        }// end function

        public function serializeAs_FightTemporarySpellImmunityEffect(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractFightDispellableEffect(param1);
            param1.writeInt(this.immuneSpellId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FightTemporarySpellImmunityEffect(param1);
            return;
        }// end function

        public function deserializeAs_FightTemporarySpellImmunityEffect(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.immuneSpellId = param1.readInt();
            return;
        }// end function

    }
}
