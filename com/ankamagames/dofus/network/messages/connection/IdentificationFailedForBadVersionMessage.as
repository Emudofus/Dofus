package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.version.Version;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class IdentificationFailedForBadVersionMessage extends IdentificationFailedMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 21;

        private var _isInitialized:Boolean = false;
        public var requiredVersion:Version;

        public function IdentificationFailedForBadVersionMessage()
        {
            this.requiredVersion = new Version();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (21);
        }

        public function initIdentificationFailedForBadVersionMessage(reason:uint=99, requiredVersion:Version=null):IdentificationFailedForBadVersionMessage
        {
            super.initIdentificationFailedMessage(reason);
            this.requiredVersion = requiredVersion;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.requiredVersion = new Version();
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_IdentificationFailedForBadVersionMessage(output);
        }

        public function serializeAs_IdentificationFailedForBadVersionMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_IdentificationFailedMessage(output);
            this.requiredVersion.serializeAs_Version(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_IdentificationFailedForBadVersionMessage(input);
        }

        public function deserializeAs_IdentificationFailedForBadVersionMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.requiredVersion = new Version();
            this.requiredVersion.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.connection

