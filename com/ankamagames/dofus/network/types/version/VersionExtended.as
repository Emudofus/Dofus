package com.ankamagames.dofus.network.types.version
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class VersionExtended extends Version implements INetworkType
    {
        public var install:uint = 0;
        public var technology:uint = 0;
        public static const protocolId:uint = 393;

        public function VersionExtended()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 393;
        }// end function

        public function initVersionExtended(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:uint = 0, param6:uint = 0, param7:uint = 0, param8:uint = 0) : VersionExtended
        {
            super.initVersion(param1, param2, param3, param4, param5, param6);
            this.install = param7;
            this.technology = param8;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.install = 0;
            this.technology = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_VersionExtended(param1);
            return;
        }// end function

        public function serializeAs_VersionExtended(param1:IDataOutput) : void
        {
            super.serializeAs_Version(param1);
            param1.writeByte(this.install);
            param1.writeByte(this.technology);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_VersionExtended(param1);
            return;
        }// end function

        public function deserializeAs_VersionExtended(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.install = param1.readByte();
            if (this.install < 0)
            {
                throw new Error("Forbidden value (" + this.install + ") on element of VersionExtended.install.");
            }
            this.technology = param1.readByte();
            if (this.technology < 0)
            {
                throw new Error("Forbidden value (" + this.technology + ") on element of VersionExtended.technology.");
            }
            return;
        }// end function

    }
}
