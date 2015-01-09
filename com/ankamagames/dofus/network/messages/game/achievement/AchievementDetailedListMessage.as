package com.ankamagames.dofus.network.messages.game.achievement
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.achievement.Achievement;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class AchievementDetailedListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6358;

        private var _isInitialized:Boolean = false;
        public var startedAchievements:Vector.<Achievement>;
        public var finishedAchievements:Vector.<Achievement>;

        public function AchievementDetailedListMessage()
        {
            this.startedAchievements = new Vector.<Achievement>();
            this.finishedAchievements = new Vector.<Achievement>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6358);
        }

        public function initAchievementDetailedListMessage(startedAchievements:Vector.<Achievement>=null, finishedAchievements:Vector.<Achievement>=null):AchievementDetailedListMessage
        {
            this.startedAchievements = startedAchievements;
            this.finishedAchievements = finishedAchievements;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.startedAchievements = new Vector.<Achievement>();
            this.finishedAchievements = new Vector.<Achievement>();
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
            this.serializeAs_AchievementDetailedListMessage(output);
        }

        public function serializeAs_AchievementDetailedListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.startedAchievements.length);
            var _i1:uint;
            while (_i1 < this.startedAchievements.length)
            {
                (this.startedAchievements[_i1] as Achievement).serializeAs_Achievement(output);
                _i1++;
            };
            output.writeShort(this.finishedAchievements.length);
            var _i2:uint;
            while (_i2 < this.finishedAchievements.length)
            {
                (this.finishedAchievements[_i2] as Achievement).serializeAs_Achievement(output);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AchievementDetailedListMessage(input);
        }

        public function deserializeAs_AchievementDetailedListMessage(input:ICustomDataInput):void
        {
            var _item1:Achievement;
            var _item2:Achievement;
            var _startedAchievementsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _startedAchievementsLen)
            {
                _item1 = new Achievement();
                _item1.deserialize(input);
                this.startedAchievements.push(_item1);
                _i1++;
            };
            var _finishedAchievementsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _finishedAchievementsLen)
            {
                _item2 = new Achievement();
                _item2.deserialize(input);
                this.finishedAchievements.push(_item2);
                _i2++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.achievement

