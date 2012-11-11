package com.ankamagames.dofus.network.types.game.context
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class EntityDispositionInformations extends Object implements INetworkType
    {
        public var cellId:int = 0;
        public var direction:uint = 1;
        public static const protocolId:uint = 60;

        public function EntityDispositionInformations()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 60;
        }// end function

        public function initEntityDispositionInformations(param1:int = 0, param2:uint = 1) : EntityDispositionInformations
        {
            this.cellId = param1;
            this.direction = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.cellId = 0;
            this.direction = 1;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_EntityDispositionInformations(param1);
            return;
        }// end function

        public function serializeAs_EntityDispositionInformations(param1:IDataOutput) : void
        {
            if (this.cellId < -1 || this.cellId > 559)
            {
                throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
            }
            param1.writeShort(this.cellId);
            param1.writeByte(this.direction);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_EntityDispositionInformations(param1);
            return;
        }// end function

        public function deserializeAs_EntityDispositionInformations(param1:IDataInput) : void
        {
            this.cellId = param1.readShort();
            if (this.cellId < -1 || this.cellId > 559)
            {
                throw new Error("Forbidden value (" + this.cellId + ") on element of EntityDispositionInformations.cellId.");
            }
            this.direction = param1.readByte();
            if (this.direction < 0)
            {
                throw new Error("Forbidden value (" + this.direction + ") on element of EntityDispositionInformations.direction.");
            }
            return;
        }// end function

    }
}
