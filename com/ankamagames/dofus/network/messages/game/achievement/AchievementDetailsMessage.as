package com.ankamagames.dofus.network.messages.game.achievement
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.achievement.Achievement;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AchievementDetailsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6378;

        private var _isInitialized:Boolean = false;
        public var achievement:Achievement;

        public function AchievementDetailsMessage()
        {
            this.achievement = new Achievement();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6378);
        }

        public function initAchievementDetailsMessage(achievement:Achievement=null):AchievementDetailsMessage
        {
            this.achievement = achievement;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.achievement = new Achievement();
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
            this.serializeAs_AchievementDetailsMessage(output);
        }

        public function serializeAs_AchievementDetailsMessage(output:ICustomDataOutput):void
        {
            this.achievement.serializeAs_Achievement(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AchievementDetailsMessage(input);
        }

        public function deserializeAs_AchievementDetailsMessage(input:ICustomDataInput):void
        {
            this.achievement = new Achievement();
            this.achievement.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.achievement

