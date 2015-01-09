package com.ankamagames.dofus.network.messages.game.context.roleplay
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class MapInformationsRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 225;

        private var _isInitialized:Boolean = false;
        public var mapId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (225);
        }

        public function initMapInformationsRequestMessage(mapId:uint=0):MapInformationsRequestMessage
        {
            this.mapId = mapId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.mapId = 0;
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_MapInformationsRequestMessage(output);
        }

        public function serializeAs_MapInformationsRequestMessage(output:IDataOutput):void
        {
            if (this.mapId < 0)
            {
                throw (new Error((("Forbidden value (" + this.mapId) + ") on element mapId.")));
            };
            output.writeInt(this.mapId);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_MapInformationsRequestMessage(input);
        }

        public function deserializeAs_MapInformationsRequestMessage(input:IDataInput):void
        {
            this.mapId = input.readInt();
            if (this.mapId < 0)
            {
                throw (new Error((("Forbidden value (" + this.mapId) + ") on element of MapInformationsRequestMessage.mapId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay

