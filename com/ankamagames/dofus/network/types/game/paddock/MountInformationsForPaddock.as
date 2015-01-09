package com.ankamagames.dofus.network.types.game.paddock
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class MountInformationsForPaddock implements INetworkType 
    {

        public static const protocolId:uint = 184;

        public var modelId:uint = 0;
        public var name:String = "";
        public var ownerName:String = "";


        public function getTypeId():uint
        {
            return (184);
        }

        public function initMountInformationsForPaddock(modelId:uint=0, name:String="", ownerName:String=""):MountInformationsForPaddock
        {
            this.modelId = modelId;
            this.name = name;
            this.ownerName = ownerName;
            return (this);
        }

        public function reset():void
        {
            this.modelId = 0;
            this.name = "";
            this.ownerName = "";
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_MountInformationsForPaddock(output);
        }

        public function serializeAs_MountInformationsForPaddock(output:ICustomDataOutput):void
        {
            if (this.modelId < 0)
            {
                throw (new Error((("Forbidden value (" + this.modelId) + ") on element modelId.")));
            };
            output.writeByte(this.modelId);
            output.writeUTF(this.name);
            output.writeUTF(this.ownerName);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MountInformationsForPaddock(input);
        }

        public function deserializeAs_MountInformationsForPaddock(input:ICustomDataInput):void
        {
            this.modelId = input.readByte();
            if (this.modelId < 0)
            {
                throw (new Error((("Forbidden value (" + this.modelId) + ") on element of MountInformationsForPaddock.modelId.")));
            };
            this.name = input.readUTF();
            this.ownerName = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.types.game.paddock

