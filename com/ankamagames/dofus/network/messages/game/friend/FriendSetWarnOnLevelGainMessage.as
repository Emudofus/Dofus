package com.ankamagames.dofus.network.messages.game.friend
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class FriendSetWarnOnLevelGainMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6077;

        private var _isInitialized:Boolean = false;
        public var enable:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6077);
        }

        public function initFriendSetWarnOnLevelGainMessage(enable:Boolean=false):FriendSetWarnOnLevelGainMessage
        {
            this.enable = enable;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.enable = false;
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
            this.serializeAs_FriendSetWarnOnLevelGainMessage(output);
        }

        public function serializeAs_FriendSetWarnOnLevelGainMessage(output:IDataOutput):void
        {
            output.writeBoolean(this.enable);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_FriendSetWarnOnLevelGainMessage(input);
        }

        public function deserializeAs_FriendSetWarnOnLevelGainMessage(input:IDataInput):void
        {
            this.enable = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.friend

