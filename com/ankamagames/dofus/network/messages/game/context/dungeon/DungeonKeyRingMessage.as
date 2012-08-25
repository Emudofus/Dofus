package com.ankamagames.dofus.network.messages.game.context.dungeon
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class DungeonKeyRingMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var availables:Vector.<uint>;
        public var unavailables:Vector.<uint>;
        public static const protocolId:uint = 6299;

        public function DungeonKeyRingMessage()
        {
            this.availables = new Vector.<uint>;
            this.unavailables = new Vector.<uint>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6299;
        }// end function

        public function initDungeonKeyRingMessage(param1:Vector.<uint> = null, param2:Vector.<uint> = null) : DungeonKeyRingMessage
        {
            this.availables = param1;
            this.unavailables = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.availables = new Vector.<uint>;
            this.unavailables = new Vector.<uint>;
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
            this.serializeAs_DungeonKeyRingMessage(param1);
            return;
        }// end function

        public function serializeAs_DungeonKeyRingMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.availables.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.availables.length)
            {
                
                if (this.availables[_loc_2] < 0)
                {
                    throw new Error("Forbidden value (" + this.availables[_loc_2] + ") on element 1 (starting at 1) of availables.");
                }
                param1.writeShort(this.availables[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.unavailables.length);
            var _loc_3:uint = 0;
            while (_loc_3 < this.unavailables.length)
            {
                
                if (this.unavailables[_loc_3] < 0)
                {
                    throw new Error("Forbidden value (" + this.unavailables[_loc_3] + ") on element 2 (starting at 1) of unavailables.");
                }
                param1.writeShort(this.unavailables[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_DungeonKeyRingMessage(param1);
            return;
        }// end function

        public function deserializeAs_DungeonKeyRingMessage(param1:IDataInput) : void
        {
            var _loc_6:uint = 0;
            var _loc_7:uint = 0;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = param1.readShort();
                if (_loc_6 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_6 + ") on elements of availables.");
                }
                this.availables.push(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:uint = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = param1.readShort();
                if (_loc_7 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_7 + ") on elements of unavailables.");
                }
                this.unavailables.push(_loc_7);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
