package com.ankamagames.dofus.network.messages.game.context.fight
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightPlacementPossiblePositionsMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var positionsForChallengers:Vector.<uint>;
        public var positionsForDefenders:Vector.<uint>;
        public var teamNumber:uint = 2;
        public static const protocolId:uint = 703;

        public function GameFightPlacementPossiblePositionsMessage()
        {
            this.positionsForChallengers = new Vector.<uint>;
            this.positionsForDefenders = new Vector.<uint>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 703;
        }// end function

        public function initGameFightPlacementPossiblePositionsMessage(param1:Vector.<uint> = null, param2:Vector.<uint> = null, param3:uint = 2) : GameFightPlacementPossiblePositionsMessage
        {
            this.positionsForChallengers = param1;
            this.positionsForDefenders = param2;
            this.teamNumber = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.positionsForChallengers = new Vector.<uint>;
            this.positionsForDefenders = new Vector.<uint>;
            this.teamNumber = 2;
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
            this.serializeAs_GameFightPlacementPossiblePositionsMessage(param1);
            return;
        }// end function

        public function serializeAs_GameFightPlacementPossiblePositionsMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.positionsForChallengers.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.positionsForChallengers.length)
            {
                
                if (this.positionsForChallengers[_loc_2] < 0 || this.positionsForChallengers[_loc_2] > 559)
                {
                    throw new Error("Forbidden value (" + this.positionsForChallengers[_loc_2] + ") on element 1 (starting at 1) of positionsForChallengers.");
                }
                param1.writeShort(this.positionsForChallengers[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.positionsForDefenders.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.positionsForDefenders.length)
            {
                
                if (this.positionsForDefenders[_loc_3] < 0 || this.positionsForDefenders[_loc_3] > 559)
                {
                    throw new Error("Forbidden value (" + this.positionsForDefenders[_loc_3] + ") on element 2 (starting at 1) of positionsForDefenders.");
                }
                param1.writeShort(this.positionsForDefenders[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            param1.writeByte(this.teamNumber);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightPlacementPossiblePositionsMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameFightPlacementPossiblePositionsMessage(param1:IDataInput) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = param1.readShort();
                if (_loc_6 < 0 || _loc_6 > 559)
                {
                    throw new Error("Forbidden value (" + _loc_6 + ") on elements of positionsForChallengers.");
                }
                this.positionsForChallengers.push(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = param1.readShort();
                if (_loc_7 < 0 || _loc_7 > 559)
                {
                    throw new Error("Forbidden value (" + _loc_7 + ") on elements of positionsForDefenders.");
                }
                this.positionsForDefenders.push(_loc_7);
                _loc_5 = _loc_5 + 1;
            }
            this.teamNumber = param1.readByte();
            if (this.teamNumber < 0)
            {
                throw new Error("Forbidden value (" + this.teamNumber + ") on element of GameFightPlacementPossiblePositionsMessage.teamNumber.");
            }
            return;
        }// end function

    }
}
