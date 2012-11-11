package com.ankamagames.dofus.network.types.game.actions.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FightTemporarySpellBoostEffect extends FightTemporaryBoostEffect implements INetworkType
    {
        public var boostedSpellId:uint = 0;
        public static const protocolId:uint = 207;

        public function FightTemporarySpellBoostEffect()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 207;
        }// end function

        public function initFightTemporarySpellBoostEffect(param1:uint = 0, param2:int = 0, param3:int = 0, param4:uint = 1, param5:uint = 0, param6:uint = 0, param7:int = 0, param8:uint = 0) : FightTemporarySpellBoostEffect
        {
            super.initFightTemporaryBoostEffect(param1, param2, param3, param4, param5, param6, param7);
            this.boostedSpellId = param8;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.boostedSpellId = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FightTemporarySpellBoostEffect(param1);
            return;
        }// end function

        public function serializeAs_FightTemporarySpellBoostEffect(param1:IDataOutput) : void
        {
            super.serializeAs_FightTemporaryBoostEffect(param1);
            if (this.boostedSpellId < 0)
            {
                throw new Error("Forbidden value (" + this.boostedSpellId + ") on element boostedSpellId.");
            }
            param1.writeShort(this.boostedSpellId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FightTemporarySpellBoostEffect(param1);
            return;
        }// end function

        public function deserializeAs_FightTemporarySpellBoostEffect(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.boostedSpellId = param1.readShort();
            if (this.boostedSpellId < 0)
            {
                throw new Error("Forbidden value (" + this.boostedSpellId + ") on element of FightTemporarySpellBoostEffect.boostedSpellId.");
            }
            return;
        }// end function

    }
}
