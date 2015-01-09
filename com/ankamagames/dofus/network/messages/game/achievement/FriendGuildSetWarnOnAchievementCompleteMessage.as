package com.ankamagames.dofus.network.messages.game.achievement
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class FriendGuildSetWarnOnAchievementCompleteMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6382;

        private var _isInitialized:Boolean = false;
        public var enable:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6382);
        }

        public function initFriendGuildSetWarnOnAchievementCompleteMessage(enable:Boolean=false):FriendGuildSetWarnOnAchievementCompleteMessage
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
            this.serializeAs_FriendGuildSetWarnOnAchievementCompleteMessage(output);
        }

        public function serializeAs_FriendGuildSetWarnOnAchievementCompleteMessage(output:IDataOutput):void
        {
            output.writeBoolean(this.enable);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_FriendGuildSetWarnOnAchievementCompleteMessage(input);
        }

        public function deserializeAs_FriendGuildSetWarnOnAchievementCompleteMessage(input:IDataInput):void
        {
            this.enable = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.achievement

