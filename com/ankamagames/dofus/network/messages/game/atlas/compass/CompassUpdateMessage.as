package com.ankamagames.dofus.network.messages.game.atlas.compass
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.MapCoordinates;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;

    [Trusted]
    public class CompassUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5591;

        private var _isInitialized:Boolean = false;
        public var type:uint = 0;
        public var coords:MapCoordinates;

        public function CompassUpdateMessage()
        {
            this.coords = new MapCoordinates();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5591);
        }

        public function initCompassUpdateMessage(type:uint=0, coords:MapCoordinates=null):CompassUpdateMessage
        {
            this.type = type;
            this.coords = coords;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.type = 0;
            this.coords = new MapCoordinates();
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
            this.serializeAs_CompassUpdateMessage(output);
        }

        public function serializeAs_CompassUpdateMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.type);
            output.writeShort(this.coords.getTypeId());
            this.coords.serialize(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CompassUpdateMessage(input);
        }

        public function deserializeAs_CompassUpdateMessage(input:ICustomDataInput):void
        {
            this.type = input.readByte();
            if (this.type < 0)
            {
                throw (new Error((("Forbidden value (" + this.type) + ") on element of CompassUpdateMessage.type.")));
            };
            var _id2:uint = input.readUnsignedShort();
            this.coords = ProtocolTypeManager.getInstance(MapCoordinates, _id2);
            this.coords.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.atlas.compass

