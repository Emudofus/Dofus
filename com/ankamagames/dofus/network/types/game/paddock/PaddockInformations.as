package com.ankamagames.dofus.network.types.game.paddock
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PaddockInformations extends Object implements INetworkType
    {
        public var maxOutdoorMount:uint = 0;
        public var maxItems:uint = 0;
        public static const protocolId:uint = 132;

        public function PaddockInformations()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 132;
        }// end function

        public function initPaddockInformations(param1:uint = 0, param2:uint = 0) : PaddockInformations
        {
            this.maxOutdoorMount = param1;
            this.maxItems = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.maxOutdoorMount = 0;
            this.maxItems = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_PaddockInformations(param1);
            return;
        }// end function

        public function serializeAs_PaddockInformations(param1:IDataOutput) : void
        {
            if (this.maxOutdoorMount < 0)
            {
                throw new Error("Forbidden value (" + this.maxOutdoorMount + ") on element maxOutdoorMount.");
            }
            param1.writeShort(this.maxOutdoorMount);
            if (this.maxItems < 0)
            {
                throw new Error("Forbidden value (" + this.maxItems + ") on element maxItems.");
            }
            param1.writeShort(this.maxItems);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PaddockInformations(param1);
            return;
        }// end function

        public function deserializeAs_PaddockInformations(param1:IDataInput) : void
        {
            this.maxOutdoorMount = param1.readShort();
            if (this.maxOutdoorMount < 0)
            {
                throw new Error("Forbidden value (" + this.maxOutdoorMount + ") on element of PaddockInformations.maxOutdoorMount.");
            }
            this.maxItems = param1.readShort();
            if (this.maxItems < 0)
            {
                throw new Error("Forbidden value (" + this.maxItems + ") on element of PaddockInformations.maxItems.");
            }
            return;
        }// end function

    }
}
