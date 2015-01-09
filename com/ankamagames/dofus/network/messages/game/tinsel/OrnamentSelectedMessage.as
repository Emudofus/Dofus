package com.ankamagames.dofus.network.messages.game.tinsel
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class OrnamentSelectedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6369;

        private var _isInitialized:Boolean = false;
        public var ornamentId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6369);
        }

        public function initOrnamentSelectedMessage(ornamentId:uint=0):OrnamentSelectedMessage
        {
            this.ornamentId = ornamentId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.ornamentId = 0;
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
            this.serializeAs_OrnamentSelectedMessage(output);
        }

        public function serializeAs_OrnamentSelectedMessage(output:IDataOutput):void
        {
            if (this.ornamentId < 0)
            {
                throw (new Error((("Forbidden value (" + this.ornamentId) + ") on element ornamentId.")));
            };
            output.writeShort(this.ornamentId);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_OrnamentSelectedMessage(input);
        }

        public function deserializeAs_OrnamentSelectedMessage(input:IDataInput):void
        {
            this.ornamentId = input.readShort();
            if (this.ornamentId < 0)
            {
                throw (new Error((("Forbidden value (" + this.ornamentId) + ") on element of OrnamentSelectedMessage.ornamentId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.tinsel

