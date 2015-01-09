package com.ankamagames.dofus.logic.game.roleplay.messages
{
    import com.ankamagames.jerakine.messages.Message;

    public class DelayedActionMessage implements Message 
    {

        private var _playerId:int;
        private var _itemId:uint;
        private var _endTime:Number;

        public function DelayedActionMessage(playerId:int, itemId:uint, endTime:Number)
        {
            this._playerId = playerId;
            this._itemId = itemId;
            this._endTime = endTime;
        }

        public function get playerId():int
        {
            return (this._playerId);
        }

        public function get itemId():uint
        {
            return (this._itemId);
        }

        public function get endTime():Number
        {
            return (this._endTime);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.messages

