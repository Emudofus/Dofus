package com.ankamagames.dofus.network.messages.game.achievement
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AchievementFinishedInformationMessage extends AchievementFinishedMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var name:String = "";
        public var playerId:uint = 0;
        public static const protocolId:uint = 6381;

        public function AchievementFinishedInformationMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6381;
        }// end function

        public function initAchievementFinishedInformationMessage(param1:uint = 0, param2:uint = 0, param3:String = "", param4:uint = 0) : AchievementFinishedInformationMessage
        {
            super.initAchievementFinishedMessage(param1, param2);
            this.name = param3;
            this.playerId = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.name = "";
            this.playerId = 0;
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_AchievementFinishedInformationMessage(param1);
            return;
        }// end function

        public function serializeAs_AchievementFinishedInformationMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AchievementFinishedMessage(param1);
            param1.writeUTF(this.name);
            if (this.playerId < 0)
            {
                throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
            }
            param1.writeInt(this.playerId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AchievementFinishedInformationMessage(param1);
            return;
        }// end function

        public function deserializeAs_AchievementFinishedInformationMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.name = param1.readUTF();
            this.playerId = param1.readInt();
            if (this.playerId < 0)
            {
                throw new Error("Forbidden value (" + this.playerId + ") on element of AchievementFinishedInformationMessage.playerId.");
            }
            return;
        }// end function

    }
}
