package com.ankamagames.dofus.network.types.game.friend
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class IgnoredInformations extends AbstractContactInformations implements INetworkType
    {
        public static const protocolId:uint = 106;

        public function IgnoredInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 106;
        }// end function

        public function initIgnoredInformations(param1:uint = 0, param2:String = "") : IgnoredInformations
        {
            super.initAbstractContactInformations(param1, param2);
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_IgnoredInformations(param1);
            return;
        }// end function

        public function serializeAs_IgnoredInformations(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractContactInformations(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_IgnoredInformations(param1);
            return;
        }// end function

        public function deserializeAs_IgnoredInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            return;
        }// end function

    }
}
