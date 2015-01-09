package com.ankamagames.dofus.network.messages.updater.parts
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.updater.ContentPart;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PartInfoMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 1508;

        private var _isInitialized:Boolean = false;
        public var part:ContentPart;
        public var installationPercent:Number = 0;

        public function PartInfoMessage()
        {
            this.part = new ContentPart();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (1508);
        }

        public function initPartInfoMessage(part:ContentPart=null, installationPercent:Number=0):PartInfoMessage
        {
            this.part = part;
            this.installationPercent = installationPercent;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.part = new ContentPart();
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_PartInfoMessage(output);
        }

        public function serializeAs_PartInfoMessage(output:ICustomDataOutput):void
        {
            this.part.serializeAs_ContentPart(output);
            output.writeFloat(this.installationPercent);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartInfoMessage(input);
        }

        public function deserializeAs_PartInfoMessage(input:ICustomDataInput):void
        {
            this.part = new ContentPart();
            this.part.deserialize(input);
            this.installationPercent = input.readFloat();
        }


    }
}//package com.ankamagames.dofus.network.messages.updater.parts

