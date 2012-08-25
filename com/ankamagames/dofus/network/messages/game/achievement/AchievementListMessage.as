package com.ankamagames.dofus.network.messages.game.achievement
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.achievement.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AchievementListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var startedAchievements:Vector.<Achievement>;
        public var finishedAchievementsIds:Vector.<uint>;
        public static const protocolId:uint = 6205;

        public function AchievementListMessage()
        {
            this.startedAchievements = new Vector.<Achievement>;
            this.finishedAchievementsIds = new Vector.<uint>;
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

        public function initAchievementListMessage(param1:Vector.<Achievement> = null, param2:Vector.<uint> = null) : AchievementListMessage
        {
            this.startedAchievements = param1;
            this.finishedAchievementsIds = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.startedAchievements = new Vector.<Achievement>;
            this.finishedAchievementsIds = new Vector.<uint>;
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
            param1.writeShort(this.startedAchievements.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.startedAchievements.length)
            {
                
                param1.writeShort((this.startedAchievements[_loc_2] as Achievement).getTypeId());
                (this.startedAchievements[_loc_2] as Achievement).serialize(param1);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.finishedAchievementsIds.length);
            var _loc_3:uint = 0;
            while (_loc_3 < this.finishedAchievementsIds.length)
            {
                
                if (this.finishedAchievementsIds[_loc_3] < 0)
                {
                    throw new Error("Forbidden value (" + this.finishedAchievementsIds[_loc_3] + ") on element 2 (starting at 1) of finishedAchievementsIds.");
                }
                param1.writeShort(this.finishedAchievementsIds[_loc_3]);
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
            var _loc_6:uint = 0;
            var _loc_7:Achievement = null;
            var _loc_8:uint = 0;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = param1.readUnsignedShort();
                _loc_7 = ProtocolTypeManager.getInstance(Achievement, _loc_6);
                _loc_7.deserialize(param1);
                this.startedAchievements.push(_loc_7);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:uint = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_8 = param1.readShort();
                if (_loc_8 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_8 + ") on elements of finishedAchievementsIds.");
                }
                this.finishedAchievementsIds.push(_loc_8);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
