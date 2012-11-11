package com.ankamagames.dofus.network.types.game.mount
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class UpdateMountIntBoost extends UpdateMountBoost implements INetworkType
    {
        public var value:int = 0;
        public static const protocolId:uint = 357;

        public function UpdateMountIntBoost()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 357;
        }// end function

        public function initUpdateMountIntBoost(param1:int = 0, param2:int = 0) : UpdateMountIntBoost
        {
            super.initUpdateMountBoost(param1);
            this.value = param2;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.value = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_UpdateMountIntBoost(param1);
            return;
        }// end function

        public function serializeAs_UpdateMountIntBoost(param1:IDataOutput) : void
        {
            super.serializeAs_UpdateMountBoost(param1);
            param1.writeInt(this.value);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_UpdateMountIntBoost(param1);
            return;
        }// end function

        public function deserializeAs_UpdateMountIntBoost(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.value = param1.readInt();
            return;
        }// end function

    }
}
