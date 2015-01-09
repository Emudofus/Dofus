package com.ankamagames.dofus.network.types.updater
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ContentPart implements INetworkType 
    {

        public static const protocolId:uint = 350;

        public var id:String = "";
        public var state:uint = 0;


        public function getTypeId():uint
        {
            return (350);
        }

        public function initContentPart(id:String="", state:uint=0):ContentPart
        {
            this.id = id;
            this.state = state;
            return (this);
        }

        public function reset():void
        {
            this.id = "";
            this.state = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ContentPart(output);
        }

        public function serializeAs_ContentPart(output:ICustomDataOutput):void
        {
            output.writeUTF(this.id);
            output.writeByte(this.state);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ContentPart(input);
        }

        public function deserializeAs_ContentPart(input:ICustomDataInput):void
        {
            this.id = input.readUTF();
            this.state = input.readByte();
            if (this.state < 0)
            {
                throw (new Error((("Forbidden value (" + this.state) + ") on element of ContentPart.state.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.updater

