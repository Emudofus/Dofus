package com.ankamagames.dofus.network.messages.game.achievement
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AchievementDetailedListRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var categoryId:uint = 0;
        public static const protocolId:uint = 6357;

        public function AchievementDetailedListRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6357;
        }// end function

        public function initAchievementDetailedListRequestMessage(param1:uint = 0) : AchievementDetailedListRequestMessage
        {
            this.categoryId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.categoryId = 0;
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
            this.serializeAs_AchievementDetailedListRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_AchievementDetailedListRequestMessage(param1:IDataOutput) : void
        {
            if (this.categoryId < 0)
            {
                throw new Error("Forbidden value (" + this.categoryId + ") on element categoryId.");
            }
            param1.writeShort(this.categoryId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AchievementDetailedListRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_AchievementDetailedListRequestMessage(param1:IDataInput) : void
        {
            this.categoryId = param1.readShort();
            if (this.categoryId < 0)
            {
                throw new Error("Forbidden value (" + this.categoryId + ") on element of AchievementDetailedListRequestMessage.categoryId.");
            }
            return;
        }// end function

    }
}
