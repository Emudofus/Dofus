package com.ankamagames.dofus.network.types.secure
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TrustCertificate extends Object implements INetworkType
    {
        public var id:uint = 0;
        public var hash:String = "";
        public static const protocolId:uint = 377;

        public function TrustCertificate()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 377;
        }// end function

        public function initTrustCertificate(param1:uint = 0, param2:String = "") : TrustCertificate
        {
            this.id = param1;
            this.hash = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.id = 0;
            this.hash = "";
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_TrustCertificate(param1);
            return;
        }// end function

        public function serializeAs_TrustCertificate(param1:IDataOutput) : void
        {
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element id.");
            }
            param1.writeInt(this.id);
            param1.writeUTF(this.hash);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TrustCertificate(param1);
            return;
        }// end function

        public function deserializeAs_TrustCertificate(param1:IDataInput) : void
        {
            this.id = param1.readInt();
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element of TrustCertificate.id.");
            }
            this.hash = param1.readUTF();
            return;
        }// end function

    }
}
