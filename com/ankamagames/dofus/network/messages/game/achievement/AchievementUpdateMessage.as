package com.ankamagames.dofus.network.messages.game.achievement
{
    import com.ankamagames.dofus.network.types.game.achievement.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AchievementUpdateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var achievement:Achievement;
        public static const protocolId:uint = 6207;

        public function AchievementUpdateMessage()
        {
            this.achievement = new Achievement();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6207;
        }// end function

        public function initAchievementUpdateMessage(param1:Achievement = null) : AchievementUpdateMessage
        {
            this.achievement = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.achievement = new Achievement();
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
            this.serializeAs_AchievementUpdateMessage(param1);
            return;
        }// end function

        public function serializeAs_AchievementUpdateMessage(param1:IDataOutput) : void
        {
            this.achievement.serializeAs_Achievement(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AchievementUpdateMessage(param1);
            return;
        }// end function

        public function deserializeAs_AchievementUpdateMessage(param1:IDataInput) : void
        {
            this.achievement = new Achievement();
            this.achievement.deserialize(param1);
            return;
        }// end function

    }
}
