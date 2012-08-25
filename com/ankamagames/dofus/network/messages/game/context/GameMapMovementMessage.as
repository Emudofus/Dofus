package com.ankamagames.dofus.network.messages.game.context
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameMapMovementMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var keyMovements:Vector.<uint>;
        public var actorId:int = 0;
        public static const protocolId:uint = 951;

        public function GameMapMovementMessage()
        {
            this.keyMovements = new Vector.<uint>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 951;
        }// end function

        public function initGameMapMovementMessage(param1:Vector.<uint> = null, param2:int = 0) : GameMapMovementMessage
        {
            this.keyMovements = param1;
            this.actorId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.keyMovements = new Vector.<uint>;
            this.actorId = 0;
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
            this.serializeAs_GameMapMovementMessage(param1);
            return;
        }// end function

        public function serializeAs_GameMapMovementMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.keyMovements.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.keyMovements.length)
            {
                
                if (this.keyMovements[_loc_2] < 0)
                {
                    throw new Error("Forbidden value (" + this.keyMovements[_loc_2] + ") on element 1 (starting at 1) of keyMovements.");
                }
                param1.writeShort(this.keyMovements[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeInt(this.actorId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameMapMovementMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameMapMovementMessage(param1:IDataInput) : void
        {
            var _loc_4:uint = 0;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readShort();
                if (_loc_4 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_4 + ") on elements of keyMovements.");
                }
                this.keyMovements.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            this.actorId = param1.readInt();
            return;
        }// end function

    }
}
