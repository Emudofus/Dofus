package com.ankamagames.dofus.network.messages.game.achievement
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AchievementRewardSuccessMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6376;

        private var _isInitialized:Boolean = false;
        public var achievementId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6376);
        }

        public function initAchievementRewardSuccessMessage(achievementId:int=0):AchievementRewardSuccessMessage
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
            this.serializeAs_AchievementRewardSuccessMessage(output);
        }

        public function serializeAs_AchievementRewardSuccessMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.achievementId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AchievementRewardSuccessMessage(input);
        }

        public function deserializeAs_AchievementRewardSuccessMessage(input:ICustomDataInput):void
        {
            this.achievementId = input.readShort();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.achievement

