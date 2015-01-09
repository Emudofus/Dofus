package com.ankamagames.dofus.network.messages.game.atlas.compass
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class CompassResetMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5584;

        private var _isInitialized:Boolean = false;
        public var type:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5584);
        }

        public function initCompassResetMessage(type:uint=0):CompassResetMessage
        {
            this.type = type;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.type = 0;
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
            this.serializeAs_CompassResetMessage(output);
        }

        public function serializeAs_CompassResetMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.type);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CompassResetMessage(input);
        }

        public function deserializeAs_CompassResetMessage(input:ICustomDataInput):void
        {
            this.type = input.readByte();
            if (this.type < 0)
            {
                throw (new Error((("Forbidden value (" + this.type) + ") on element of CompassResetMessage.type.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.atlas.compass

