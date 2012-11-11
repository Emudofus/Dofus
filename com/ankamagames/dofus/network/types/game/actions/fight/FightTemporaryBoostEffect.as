package com.ankamagames.dofus.network.types.game.actions.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FightTemporaryBoostEffect extends AbstractFightDispellableEffect implements INetworkType
    {
        public var delta:int = 0;
        public static const protocolId:uint = 209;

        public function FightTemporaryBoostEffect()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 209;
        }// end function

        public function initFightTemporaryBoostEffect(param1:uint = 0, param2:int = 0, param3:int = 0, param4:uint = 1, param5:uint = 0, param6:uint = 0, param7:int = 0) : FightTemporaryBoostEffect
        {
            super.initAbstractFightDispellableEffect(param1, param2, param3, param4, param5, param6);
            this.delta = param7;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.delta = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FightTemporaryBoostEffect(param1);
            return;
        }// end function

        public function serializeAs_FightTemporaryBoostEffect(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractFightDispellableEffect(param1);
            param1.writeShort(this.delta);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FightTemporaryBoostEffect(param1);
            return;
        }// end function

        public function deserializeAs_FightTemporaryBoostEffect(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.delta = param1.readShort();
            return;
        }// end function

    }
}
