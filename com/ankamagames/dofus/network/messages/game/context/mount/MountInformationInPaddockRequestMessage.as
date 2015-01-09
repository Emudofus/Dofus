package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class MountInformationInPaddockRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5975;

        private var _isInitialized:Boolean = false;
        public var mapRideId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5975);
        }

        public function initMountInformationInPaddockRequestMessage(mapRideId:int=0):MountInformationInPaddockRequestMessage
        {
            this.mapRideId = mapRideId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.mapRideId = 0;
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
            this.serializeAs_MountInformationInPaddockRequestMessage(output);
        }

        public function serializeAs_MountInformationInPaddockRequestMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.mapRideId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MountInformationInPaddockRequestMessage(input);
        }

        public function deserializeAs_MountInformationInPaddockRequestMessage(input:ICustomDataInput):void
        {
            this.mapRideId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.mount

