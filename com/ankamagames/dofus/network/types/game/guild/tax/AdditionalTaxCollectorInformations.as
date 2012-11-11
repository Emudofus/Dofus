package com.ankamagames.dofus.network.types.game.guild.tax
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AdditionalTaxCollectorInformations extends Object implements INetworkType
    {
        public var collectorCallerName:String = "";
        public var date:uint = 0;
        public static const protocolId:uint = 165;

        public function AdditionalTaxCollectorInformations()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 165;
        }// end function

        public function initAdditionalTaxCollectorInformations(param1:String = "", param2:uint = 0) : AdditionalTaxCollectorInformations
        {
            this.collectorCallerName = param1;
            this.date = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.collectorCallerName = "";
            this.date = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_AdditionalTaxCollectorInformations(param1);
            return;
        }// end function

        public function serializeAs_AdditionalTaxCollectorInformations(param1:IDataOutput) : void
        {
            param1.writeUTF(this.collectorCallerName);
            if (this.date < 0)
            {
                throw new Error("Forbidden value (" + this.date + ") on element date.");
            }
            param1.writeInt(this.date);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AdditionalTaxCollectorInformations(param1);
            return;
        }// end function

        public function deserializeAs_AdditionalTaxCollectorInformations(param1:IDataInput) : void
        {
            this.collectorCallerName = param1.readUTF();
            this.date = param1.readInt();
            if (this.date < 0)
            {
                throw new Error("Forbidden value (" + this.date + ") on element of AdditionalTaxCollectorInformations.date.");
            }
            return;
        }// end function

    }
}
