package com.ankamagames.dofus.network.messages.game.achievement
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class AchievementDetailsRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6380;

        private var _isInitialized:Boolean = false;
        public var achievementId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6380);
        }

        public function initAchievementDetailsRequestMessage(achievementId:uint=0):AchievementDetailsRequestMessage
        {
            this.achievementId = achievementId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.achievementId = 0;
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
            this.serializeAs_AchievementDetailsRequestMessage(output);
        }

        public function serializeAs_AchievementDetailsRequestMessage(output:IDataOutput):void
        {
            if (this.achievementId < 0)
            {
                throw (new Error((("Forbidden value (" + this.achievementId) + ") on element achievementId.")));
            };
            output.writeShort(this.achievementId);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_AchievementDetailsRequestMessage(input);
        }

        public function deserializeAs_AchievementDetailsRequestMessage(input:IDataInput):void
        {
            this.achievementId = input.readShort();
            if (this.achievementId < 0)
            {
                throw (new Error((("Forbidden value (" + this.achievementId) + ") on element of AchievementDetailsRequestMessage.achievementId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.achievement

