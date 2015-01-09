package com.ankamagames.dofus.network.messages.game.achievement
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AchievementRewardErrorMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6375;

        private var _isInitialized:Boolean = false;
        public var achievementId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6375);
        }

        public function initAchievementRewardErrorMessage(achievementId:int=0):AchievementRewardErrorMessage
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
            this.serializeAs_AchievementRewardErrorMessage(output);
        }

        public function serializeAs_AchievementRewardErrorMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.achievementId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AchievementRewardErrorMessage(input);
        }

        public function deserializeAs_AchievementRewardErrorMessage(input:ICustomDataInput):void
        {
            this.achievementId = input.readShort();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.achievement

