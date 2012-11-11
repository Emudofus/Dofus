package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ChallengeTargetsListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var targetIds:Vector.<int>;
        public var targetCells:Vector.<int>;
        public static const protocolId:uint = 5613;

        public function ChallengeTargetsListMessage()
        {
            this.targetIds = new Vector.<int>;
            this.targetCells = new Vector.<int>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5613;
        }// end function

        public function initChallengeTargetsListMessage(param1:Vector.<int> = null, param2:Vector.<int> = null) : ChallengeTargetsListMessage
        {
            this.targetIds = param1;
            this.targetCells = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.targetIds = new Vector.<int>;
            this.targetCells = new Vector.<int>;
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
            this.serializeAs_ChallengeTargetsListMessage(param1);
            return;
        }// end function

        public function serializeAs_ChallengeTargetsListMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.targetIds.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.targetIds.length)
            {
                
                param1.writeInt(this.targetIds[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.targetCells.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.targetCells.length)
            {
                
                if (this.targetCells[_loc_3] < -1 || this.targetCells[_loc_3] > 559)
                {
                    throw new Error("Forbidden value (" + this.targetCells[_loc_3] + ") on element 2 (starting at 1) of targetCells.");
                }
                param1.writeShort(this.targetCells[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ChallengeTargetsListMessage(param1);
            return;
        }// end function

        public function deserializeAs_ChallengeTargetsListMessage(param1:IDataInput) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = param1.readInt();
                this.targetIds.push(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = param1.readShort();
                if (_loc_7 < -1 || _loc_7 > 559)
                {
                    throw new Error("Forbidden value (" + _loc_7 + ") on elements of targetCells.");
                }
                this.targetCells.push(_loc_7);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
