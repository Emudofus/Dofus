package com.ankamagames.dofus.network.messages.game.achievement
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.achievement.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AchievementListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var finishedAchievementsIds:Vector.<uint>;
        public var rewardableAchievements:Vector.<AchievementRewardable>;
        public static const protocolId:uint = 6205;

        public function AchievementListMessage()
        {
            this.finishedAchievementsIds = new Vector.<uint>;
            this.rewardableAchievements = new Vector.<AchievementRewardable>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6205;
        }// end function

        public function initAchievementListMessage(param1:Vector.<uint> = null, param2:Vector.<AchievementRewardable> = null) : AchievementListMessage
        {
            this.finishedAchievementsIds = param1;
            this.rewardableAchievements = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.finishedAchievementsIds = new Vector.<uint>;
            this.rewardableAchievements = new Vector.<AchievementRewardable>;
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
            this.serializeAs_AchievementListMessage(param1);
            return;
        }// end function

        public function serializeAs_AchievementListMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.finishedAchievementsIds.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.finishedAchievementsIds.length)
            {
                
                if (this.finishedAchievementsIds[_loc_2] < 0)
                {
                    throw new Error("Forbidden value (" + this.finishedAchievementsIds[_loc_2] + ") on element 1 (starting at 1) of finishedAchievementsIds.");
                }
                param1.writeShort(this.finishedAchievementsIds[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.rewardableAchievements.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.rewardableAchievements.length)
            {
                
                (this.rewardableAchievements[_loc_3] as AchievementRewardable).serializeAs_AchievementRewardable(param1);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AchievementListMessage(param1);
            return;
        }// end function

        public function deserializeAs_AchievementListMessage(param1:IDataInput) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = param1.readShort();
                if (_loc_6 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_6 + ") on elements of finishedAchievementsIds.");
                }
                this.finishedAchievementsIds.push(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = new AchievementRewardable();
                _loc_7.deserialize(param1);
                this.rewardableAchievements.push(_loc_7);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
