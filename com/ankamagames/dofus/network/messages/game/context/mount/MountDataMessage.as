package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.mount.MountClientData;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class MountDataMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5973;

        private var _isInitialized:Boolean = false;
        public var mountData:MountClientData;

        public function MountDataMessage()
        {
            this.mountData = new MountClientData();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5973);
        }

        public function initMountDataMessage(mountData:MountClientData=null):MountDataMessage
        {
            this.mountData = mountData;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.mountData = new MountClientData();
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
            this.serializeAs_MountDataMessage(output);
        }

        public function serializeAs_MountDataMessage(output:ICustomDataOutput):void
        {
            this.mountData.serializeAs_MountClientData(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MountDataMessage(input);
        }

        public function deserializeAs_MountDataMessage(input:ICustomDataInput):void
        {
            this.mountData = new MountClientData();
            this.mountData.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.mount

