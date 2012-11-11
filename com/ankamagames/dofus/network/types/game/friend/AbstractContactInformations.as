package com.ankamagames.dofus.network.types.game.friend
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AbstractContactInformations extends Object implements INetworkType
    {
        public var accountId:uint = 0;
        public var accountName:String = "";
        public static const protocolId:uint = 380;

        public function AbstractContactInformations()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 380;
        }// end function

        public function initAbstractContactInformations(param1:uint = 0, param2:String = "") : AbstractContactInformations
        {
            this.accountId = param1;
            this.accountName = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.accountId = 0;
            this.accountName = "";
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_AbstractContactInformations(param1);
            return;
        }// end function

        public function serializeAs_AbstractContactInformations(param1:IDataOutput) : void
        {
            if (this.accountId < 0)
            {
                throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
            }
            param1.writeInt(this.accountId);
            param1.writeUTF(this.accountName);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AbstractContactInformations(param1);
            return;
        }// end function

        public function deserializeAs_AbstractContactInformations(param1:IDataInput) : void
        {
            this.accountId = param1.readInt();
            if (this.accountId < 0)
            {
                throw new Error("Forbidden value (" + this.accountId + ") on element of AbstractContactInformations.accountId.");
            }
            this.accountName = param1.readUTF();
            return;
        }// end function

    }
}
