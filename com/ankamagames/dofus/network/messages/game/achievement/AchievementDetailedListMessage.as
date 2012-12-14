package com.ankamagames.dofus.network.messages.game.achievement
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.achievement.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AchievementDetailedListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var startedAchievements:Vector.<Achievement>;
        public var finishedAchievements:Vector.<Achievement>;
        public static const protocolId:uint = 6358;

        public function AchievementDetailedListMessage()
        {
            this.startedAchievements = new Vector.<Achievement>;
            this.finishedAchievements = new Vector.<Achievement>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6358;
        }// end function

        public function initAchievementDetailedListMessage(param1:Vector.<Achievement> = null, param2:Vector.<Achievement> = null) : AchievementDetailedListMessage
        {
            this.startedAchievements = param1;
            this.finishedAchievements = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.startedAchievements = new Vector.<Achievement>;
            this.finishedAchievements = new Vector.<Achievement>;
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
            this.serializeAs_AchievementDetailedListMessage(param1);
            return;
        }// end function

        public function serializeAs_AchievementDetailedListMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.startedAchievements.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.startedAchievements.length)
            {
                
                (this.startedAchievements[_loc_2] as Achievement).serializeAs_Achievement(param1);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.finishedAchievements.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.finishedAchievements.length)
            {
                
                (this.finishedAchievements[_loc_3] as Achievement).serializeAs_Achievement(param1);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AchievementDetailedListMessage(param1);
            return;
        }// end function

        public function deserializeAs_AchievementDetailedListMessage(param1:IDataInput) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = new Achievement();
                _loc_6.deserialize(param1);
                this.startedAchievements.push(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = new Achievement();
                _loc_7.deserialize(param1);
                this.finishedAchievements.push(_loc_7);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
