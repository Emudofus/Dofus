package com.ankamagames.dofus.network.types.game.mount
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class UpdateMountBoost extends Object implements INetworkType
    {
        public var type:int = 0;
        public static const protocolId:uint = 356;

        public function UpdateMountBoost()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 356;
        }// end function

        public function initUpdateMountBoost(param1:int = 0) : UpdateMountBoost
        {
            this.type = param1;
            return this;
        }// end function

        public function reset() : void
        {
            this.type = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_UpdateMountBoost(param1);
            return;
        }// end function

        public function serializeAs_UpdateMountBoost(param1:IDataOutput) : void
        {
            param1.writeByte(this.type);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_UpdateMountBoost(param1);
            return;
        }// end function

        public function deserializeAs_UpdateMountBoost(param1:IDataInput) : void
        {
            this.type = param1.readByte();
            return;
        }// end function

    }
}
