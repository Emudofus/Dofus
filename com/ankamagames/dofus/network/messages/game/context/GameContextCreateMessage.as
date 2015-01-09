package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameContextCreateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 200;

        private var _isInitialized:Boolean = false;
        public var context:uint = 1;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (200);
        }

        public function initGameContextCreateMessage(context:uint=1):GameContextCreateMessage
        {
            this.context = context;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.context = 1;
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
            this.serializeAs_GameContextCreateMessage(output);
        }

        public function serializeAs_GameContextCreateMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.context);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameContextCreateMessage(input);
        }

        public function deserializeAs_GameContextCreateMessage(input:ICustomDataInput):void
        {
            this.context = input.readByte();
            if (this.context < 0)
            {
                throw (new Error((("Forbidden value (" + this.context) + ") on element of GameContextCreateMessage.context.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context

