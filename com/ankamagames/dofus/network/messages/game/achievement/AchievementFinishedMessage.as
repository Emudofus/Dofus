package com.ankamagames.dofus.network.messages.game.achievement
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AchievementFinishedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var achievementId:uint = 0;
        public static const protocolId:uint = 6208;

        public function AchievementFinishedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6208;
        }// end function

        public function initAchievementFinishedMessage(param1:uint = 0) : AchievementFinishedMessage
        {
            this.achievementId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.achievementId = 0;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_AchievementFinishedMessage(param1);
            return;
        }// end function

        public function serializeAs_AchievementFinishedMessage(param1:IDataOutput) : void
        {
            if (this.achievementId < 0)
            {
                throw new Error("Forbidden value (" + this.achievementId + ") on element achievementId.");
            }
            param1.writeShort(this.achievementId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AchievementFinishedMessage(param1);
            return;
        }// end function

        public function deserializeAs_AchievementFinishedMessage(param1:IDataInput) : void
        {
            this.achievementId = param1.readShort();
            if (this.achievementId < 0)
            {
                throw new Error("Forbidden value (" + this.achievementId + ") on element of AchievementFinishedMessage.achievementId.");
            }
            return;
        }// end function

    }
}
