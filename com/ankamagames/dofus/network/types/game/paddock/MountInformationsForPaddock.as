package com.ankamagames.dofus.network.types.game.paddock
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MountInformationsForPaddock extends Object implements INetworkType
    {
        public var modelId:int = 0;
        public var name:String = "";
        public var ownerName:String = "";
        public static const protocolId:uint = 184;

        public function MountInformationsForPaddock()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 184;
        }// end function

        public function initMountInformationsForPaddock(param1:int = 0, param2:String = "", param3:String = "") : MountInformationsForPaddock
        {
            this.modelId = param1;
            this.name = param2;
            this.ownerName = param3;
            return this;
        }// end function

        public function reset() : void
        {
            this.modelId = 0;
            this.name = "";
            this.ownerName = "";
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_MountInformationsForPaddock(param1);
            return;
        }// end function

        public function serializeAs_MountInformationsForPaddock(param1:IDataOutput) : void
        {
            param1.writeInt(this.modelId);
            param1.writeUTF(this.name);
            param1.writeUTF(this.ownerName);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MountInformationsForPaddock(param1);
            return;
        }// end function

        public function deserializeAs_MountInformationsForPaddock(param1:IDataInput) : void
        {
            this.modelId = param1.readInt();
            this.name = param1.readUTF();
            this.ownerName = param1.readUTF();
            return;
        }// end function

    }
}
