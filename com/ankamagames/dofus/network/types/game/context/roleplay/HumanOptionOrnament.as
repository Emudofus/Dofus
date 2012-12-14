package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HumanOptionOrnament extends HumanOption implements INetworkType
    {
        public var ornamentId:uint = 0;
        public static const protocolId:uint = 411;

        public function HumanOptionOrnament()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 411;
        }// end function

        public function initHumanOptionOrnament(param1:uint = 0) : HumanOptionOrnament
        {
            this.ornamentId = param1;
            return this;
        }// end function

        override public function reset() : void
        {
            this.ornamentId = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_HumanOptionOrnament(param1);
            return;
        }// end function

        public function serializeAs_HumanOptionOrnament(param1:IDataOutput) : void
        {
            super.serializeAs_HumanOption(param1);
            if (this.ornamentId < 0)
            {
                throw new Error("Forbidden value (" + this.ornamentId + ") on element ornamentId.");
            }
            param1.writeShort(this.ornamentId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HumanOptionOrnament(param1);
            return;
        }// end function

        public function deserializeAs_HumanOptionOrnament(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.ornamentId = param1.readShort();
            if (this.ornamentId < 0)
            {
                throw new Error("Forbidden value (" + this.ornamentId + ") on element of HumanOptionOrnament.ornamentId.");
            }
            return;
        }// end function

    }
}
