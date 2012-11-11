package com.ankamagames.dofus.network.types.game.actions.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FightTriggeredEffect extends AbstractFightDispellableEffect implements INetworkType
    {
        public var param1:int = 0;
        public var param2:int = 0;
        public var param3:int = 0;
        public var delay:int = 0;
        public static const protocolId:uint = 210;

        public function FightTriggeredEffect()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 210;
        }// end function

        public function initFightTriggeredEffect(param1:uint = 0, param2:int = 0, param3:int = 0, param4:uint = 1, param5:uint = 0, param6:uint = 0, param7:int = 0, param8:int = 0, param9:int = 0, param10:int = 0) : FightTriggeredEffect
        {
            super.initAbstractFightDispellableEffect(param1, param2, param3, param4, param5, param6);
            this.param1 = param7;
            this.param2 = param8;
            this.param3 = param9;
            this.delay = param10;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.param1 = 0;
            this.param2 = 0;
            this.param3 = 0;
            this.delay = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FightTriggeredEffect(param1);
            return;
        }// end function

        public function serializeAs_FightTriggeredEffect(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractFightDispellableEffect(param1);
            param1.writeInt(this.param1);
            param1.writeInt(this.param2);
            param1.writeInt(this.param3);
            param1.writeShort(this.delay);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FightTriggeredEffect(param1);
            return;
        }// end function

        public function deserializeAs_FightTriggeredEffect(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.param1 = param1.readInt();
            this.param2 = param1.readInt();
            this.param3 = param1.readInt();
            this.delay = param1.readShort();
            return;
        }// end function

    }
}
