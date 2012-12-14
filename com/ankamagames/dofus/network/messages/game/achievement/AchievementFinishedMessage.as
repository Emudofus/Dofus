package com.ankamagames.dofus.network.messages.game.achievement
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AchievementFinishedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var id:uint = 0;
        public var finishedlevel:uint = 0;
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

        public function initAchievementFinishedMessage(param1:uint = 0, param2:uint = 0) : AchievementFinishedMessage
        {
            this.id = param1;
            this.finishedlevel = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.id = 0;
            this.finishedlevel = 0;
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
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element id.");
            }
            param1.writeShort(this.id);
            if (this.finishedlevel < 0 || this.finishedlevel > 200)
            {
                throw new Error("Forbidden value (" + this.finishedlevel + ") on element finishedlevel.");
            }
            param1.writeShort(this.finishedlevel);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AchievementFinishedMessage(param1);
            return;
        }// end function

        public function deserializeAs_AchievementFinishedMessage(param1:IDataInput) : void
        {
            this.id = param1.readShort();
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element of AchievementFinishedMessage.id.");
            }
            this.finishedlevel = param1.readShort();
            if (this.finishedlevel < 0 || this.finishedlevel > 200)
            {
                throw new Error("Forbidden value (" + this.finishedlevel + ") on element of AchievementFinishedMessage.finishedlevel.");
            }
            return;
        }// end function

    }
}
