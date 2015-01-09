package com.ankamagames.dofus.network.messages.game.friend
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class FriendAddRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 4004;

        private var _isInitialized:Boolean = false;
        public var name:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (4004);
        }

        public function initFriendAddRequestMessage(name:String=""):FriendAddRequestMessage
        {
            this.name = name;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.name = "";
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
            this.serializeAs_FriendAddRequestMessage(output);
        }

        public function serializeAs_FriendAddRequestMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.name);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_FriendAddRequestMessage(input);
        }

        public function deserializeAs_FriendAddRequestMessage(input:ICustomDataInput):void
        {
            this.name = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.friend

