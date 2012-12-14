package com.ankamagames.dofus.network.messages.game.tinsel
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TitlesAndOrnamentsListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var titles:Vector.<uint>;
        public var ornaments:Vector.<uint>;
        public var activeTitle:uint = 0;
        public var activeOrnament:uint = 0;
        public static const protocolId:uint = 6367;

        public function TitlesAndOrnamentsListMessage()
        {
            this.titles = new Vector.<uint>;
            this.ornaments = new Vector.<uint>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6367;
        }// end function

        public function initTitlesAndOrnamentsListMessage(param1:Vector.<uint> = null, param2:Vector.<uint> = null, param3:uint = 0, param4:uint = 0) : TitlesAndOrnamentsListMessage
        {
            this.titles = param1;
            this.ornaments = param2;
            this.activeTitle = param3;
            this.activeOrnament = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.titles = new Vector.<uint>;
            this.ornaments = new Vector.<uint>;
            this.activeTitle = 0;
            this.activeOrnament = 0;
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
            this.serializeAs_TitlesAndOrnamentsListMessage(param1);
            return;
        }// end function

        public function serializeAs_TitlesAndOrnamentsListMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.titles.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.titles.length)
            {
                
                if (this.titles[_loc_2] < 0)
                {
                    throw new Error("Forbidden value (" + this.titles[_loc_2] + ") on element 1 (starting at 1) of titles.");
                }
                param1.writeShort(this.titles[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.ornaments.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.ornaments.length)
            {
                
                if (this.ornaments[_loc_3] < 0)
                {
                    throw new Error("Forbidden value (" + this.ornaments[_loc_3] + ") on element 2 (starting at 1) of ornaments.");
                }
                param1.writeShort(this.ornaments[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            if (this.activeTitle < 0)
            {
                throw new Error("Forbidden value (" + this.activeTitle + ") on element activeTitle.");
            }
            param1.writeShort(this.activeTitle);
            if (this.activeOrnament < 0)
            {
                throw new Error("Forbidden value (" + this.activeOrnament + ") on element activeOrnament.");
            }
            param1.writeShort(this.activeOrnament);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TitlesAndOrnamentsListMessage(param1);
            return;
        }// end function

        public function deserializeAs_TitlesAndOrnamentsListMessage(param1:IDataInput) : void
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
                    throw new Error("Forbidden value (" + _loc_6 + ") on elements of titles.");
                }
                this.titles.push(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = param1.readShort();
                if (_loc_7 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_7 + ") on elements of ornaments.");
                }
                this.ornaments.push(_loc_7);
                _loc_5 = _loc_5 + 1;
            }
            this.activeTitle = param1.readShort();
            if (this.activeTitle < 0)
            {
                throw new Error("Forbidden value (" + this.activeTitle + ") on element of TitlesAndOrnamentsListMessage.activeTitle.");
            }
            this.activeOrnament = param1.readShort();
            if (this.activeOrnament < 0)
            {
                throw new Error("Forbidden value (" + this.activeOrnament + ") on element of TitlesAndOrnamentsListMessage.activeOrnament.");
            }
            return;
        }// end function

    }
}
