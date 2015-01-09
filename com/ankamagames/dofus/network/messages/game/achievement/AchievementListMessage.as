package com.ankamagames.dofus.network.messages.game.achievement
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.achievement.AchievementRewardable;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class AchievementListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6205;

        private var _isInitialized:Boolean = false;
        public var finishedAchievementsIds:Vector.<uint>;
        public var rewardableAchievements:Vector.<AchievementRewardable>;

        public function AchievementListMessage()
        {
            this.finishedAchievementsIds = new Vector.<uint>();
            this.rewardableAchievements = new Vector.<AchievementRewardable>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6205);
        }

        public function initAchievementListMessage(finishedAchievementsIds:Vector.<uint>=null, rewardableAchievements:Vector.<AchievementRewardable>=null):AchievementListMessage
        {
            this.finishedAchievementsIds = finishedAchievementsIds;
            this.rewardableAchievements = rewardableAchievements;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.finishedAchievementsIds = new Vector.<uint>();
            this.rewardableAchievements = new Vector.<AchievementRewardable>();
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_AchievementListMessage(output);
        }

        public function serializeAs_AchievementListMessage(output:IDataOutput):void
        {
            output.writeShort(this.finishedAchievementsIds.length);
            var _i1:uint;
            while (_i1 < this.finishedAchievementsIds.length)
            {
                if (this.finishedAchievementsIds[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.finishedAchievementsIds[_i1]) + ") on element 1 (starting at 1) of finishedAchievementsIds.")));
                };
                output.writeShort(this.finishedAchievementsIds[_i1]);
                _i1++;
            };
            output.writeShort(this.rewardableAchievements.length);
            var _i2:uint;
            while (_i2 < this.rewardableAchievements.length)
            {
                (this.rewardableAchievements[_i2] as AchievementRewardable).serializeAs_AchievementRewardable(output);
                _i2++;
            };
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_AchievementListMessage(input);
        }

        public function deserializeAs_AchievementListMessage(input:IDataInput):void
        {
            var _val1:uint;
            var _item2:AchievementRewardable;
            var _finishedAchievementsIdsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _finishedAchievementsIdsLen)
            {
                _val1 = input.readShort();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of finishedAchievementsIds.")));
                };
                this.finishedAchievementsIds.push(_val1);
                _i1++;
            };
            var _rewardableAchievementsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _rewardableAchievementsLen)
            {
                _item2 = new AchievementRewardable();
                _item2.deserialize(input);
                this.rewardableAchievements.push(_item2);
                _i2++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.achievement

