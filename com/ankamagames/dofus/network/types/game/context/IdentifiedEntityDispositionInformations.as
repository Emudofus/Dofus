package com.ankamagames.dofus.network.types.game.context
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class IdentifiedEntityDispositionInformations extends EntityDispositionInformations implements INetworkType
    {
        public var id:int = 0;
        public static const protocolId:uint = 107;

        public function IdentifiedEntityDispositionInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 107;
        }// end function

        public function initIdentifiedEntityDispositionInformations(param1:int = 0, param2:uint = 1, param3:int = 0) : IdentifiedEntityDispositionInformations
        {
            super.initEntityDispositionInformations(param1, param2);
            this.id = param3;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.id = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_IdentifiedEntityDispositionInformations(param1);
            return;
        }// end function

        public function serializeAs_IdentifiedEntityDispositionInformations(param1:IDataOutput) : void
        {
            super.serializeAs_EntityDispositionInformations(param1);
            param1.writeInt(this.id);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_IdentifiedEntityDispositionInformations(param1);
            return;
        }// end function

        public function deserializeAs_IdentifiedEntityDispositionInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.id = param1.readInt();
            return;
        }// end function

    }
}
