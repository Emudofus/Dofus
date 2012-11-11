package com.ankamagames.dofus.network.types.game.context.roleplay.quest
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayNpcQuestFlag extends Object implements INetworkType
    {
        public var questsToValidId:Vector.<uint>;
        public var questsToStartId:Vector.<uint>;
        public static const protocolId:uint = 384;

        public function GameRolePlayNpcQuestFlag()
        {
            this.questsToValidId = new Vector.<uint>;
            this.questsToStartId = new Vector.<uint>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 384;
        }// end function

        public function initGameRolePlayNpcQuestFlag(param1:Vector.<uint> = null, param2:Vector.<uint> = null) : GameRolePlayNpcQuestFlag
        {
            this.questsToValidId = param1;
            this.questsToStartId = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.questsToValidId = new Vector.<uint>;
            this.questsToStartId = new Vector.<uint>;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameRolePlayNpcQuestFlag(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayNpcQuestFlag(param1:IDataOutput) : void
        {
            param1.writeShort(this.questsToValidId.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.questsToValidId.length)
            {
                
                if (this.questsToValidId[_loc_2] < 0)
                {
                    throw new Error("Forbidden value (" + this.questsToValidId[_loc_2] + ") on element 1 (starting at 1) of questsToValidId.");
                }
                param1.writeShort(this.questsToValidId[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.questsToStartId.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.questsToStartId.length)
            {
                
                if (this.questsToStartId[_loc_3] < 0)
                {
                    throw new Error("Forbidden value (" + this.questsToStartId[_loc_3] + ") on element 2 (starting at 1) of questsToStartId.");
                }
                param1.writeShort(this.questsToStartId[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayNpcQuestFlag(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayNpcQuestFlag(param1:IDataInput) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = param1.readShort();
                if (_loc_6 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_6 + ") on elements of questsToValidId.");
                }
                this.questsToValidId.push(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = param1.readShort();
                if (_loc_7 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_7 + ") on elements of questsToStartId.");
                }
                this.questsToStartId.push(_loc_7);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
