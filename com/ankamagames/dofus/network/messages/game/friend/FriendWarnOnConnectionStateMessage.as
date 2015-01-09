package com.ankamagames.dofus.network.messages.game.friend
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class FriendWarnOnConnectionStateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5630;

        private var _isInitialized:Boolean = false;
        public var enable:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5630);
        }

        public function initFriendWarnOnConnectionStateMessage(enable:Boolean=false):FriendWarnOnConnectionStateMessage
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
            this.serializeAs_FriendWarnOnConnectionStateMessage(output);
        }

        public function serializeAs_FriendWarnOnConnectionStateMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.enable);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_FriendWarnOnConnectionStateMessage(input);
        }

        public function deserializeAs_FriendWarnOnConnectionStateMessage(input:ICustomDataInput):void
        {
            this.enable = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.friend

