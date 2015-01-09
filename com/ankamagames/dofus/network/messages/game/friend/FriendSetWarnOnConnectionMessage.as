package com.ankamagames.dofus.network.messages.game.friend
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class FriendSetWarnOnConnectionMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5602;

        private var _isInitialized:Boolean = false;
        public var enable:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5602);
        }

        public function initFriendSetWarnOnConnectionMessage(enable:Boolean=false):FriendSetWarnOnConnectionMessage
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
            this.serializeAs_FriendSetWarnOnConnectionMessage(output);
        }

        public function serializeAs_FriendSetWarnOnConnectionMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.enable);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_FriendSetWarnOnConnectionMessage(input);
        }

        public function deserializeAs_FriendSetWarnOnConnectionMessage(input:ICustomDataInput):void
        {
            this.enable = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.friend

