package com.ankamagames.dofus.network.messages.game.context.roleplay.objects
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectGroundListAddedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var cells:Vector.<uint>;
        public var referenceIds:Vector.<uint>;
        public static const protocolId:uint = 5925;

        public function ObjectGroundListAddedMessage()
        {
            this.cells = new Vector.<uint>;
            this.referenceIds = new Vector.<uint>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5925;
        }// end function

        public function initObjectGroundListAddedMessage(param1:Vector.<uint> = null, param2:Vector.<uint> = null) : ObjectGroundListAddedMessage
        {
            this.cells = param1;
            this.referenceIds = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.cells = new Vector.<uint>;
            this.referenceIds = new Vector.<uint>;
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
            this.serializeAs_ObjectGroundListAddedMessage(param1);
            return;
        }// end function

        public function serializeAs_ObjectGroundListAddedMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.cells.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.cells.length)
            {
                
                if (this.cells[_loc_2] < 0 || this.cells[_loc_2] > 559)
                {
                    throw new Error("Forbidden value (" + this.cells[_loc_2] + ") on element 1 (starting at 1) of cells.");
                }
                param1.writeShort(this.cells[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.referenceIds.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.referenceIds.length)
            {
                
                if (this.referenceIds[_loc_3] < 0)
                {
                    throw new Error("Forbidden value (" + this.referenceIds[_loc_3] + ") on element 2 (starting at 1) of referenceIds.");
                }
                param1.writeInt(this.referenceIds[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectGroundListAddedMessage(param1);
            return;
        }// end function

        public function deserializeAs_ObjectGroundListAddedMessage(param1:IDataInput) : void
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
                    throw new Error("Forbidden value (" + _loc_6 + ") on elements of cells.");
                }
                this.cells.push(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = param1.readInt();
                if (_loc_7 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_7 + ") on elements of referenceIds.");
                }
                this.referenceIds.push(_loc_7);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
