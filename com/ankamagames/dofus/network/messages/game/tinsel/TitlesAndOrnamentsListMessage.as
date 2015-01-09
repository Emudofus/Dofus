package com.ankamagames.dofus.network.messages.game.tinsel
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class TitlesAndOrnamentsListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6367;

        private var _isInitialized:Boolean = false;
        public var titles:Vector.<uint>;
        public var ornaments:Vector.<uint>;
        public var activeTitle:uint = 0;
        public var activeOrnament:uint = 0;

        public function TitlesAndOrnamentsListMessage()
        {
            this.titles = new Vector.<uint>();
            this.ornaments = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6367);
        }

        public function initTitlesAndOrnamentsListMessage(titles:Vector.<uint>=null, ornaments:Vector.<uint>=null, activeTitle:uint=0, activeOrnament:uint=0):TitlesAndOrnamentsListMessage
        {
            this.titles = titles;
            this.ornaments = ornaments;
            this.activeTitle = activeTitle;
            this.activeOrnament = activeOrnament;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.titles = new Vector.<uint>();
            this.ornaments = new Vector.<uint>();
            this.activeTitle = 0;
            this.activeOrnament = 0;
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
            this.serializeAs_TitlesAndOrnamentsListMessage(output);
        }

        public function serializeAs_TitlesAndOrnamentsListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.titles.length);
            var _i1:uint;
            while (_i1 < this.titles.length)
            {
                if (this.titles[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.titles[_i1]) + ") on element 1 (starting at 1) of titles.")));
                };
                output.writeVarShort(this.titles[_i1]);
                _i1++;
            };
            output.writeShort(this.ornaments.length);
            var _i2:uint;
            while (_i2 < this.ornaments.length)
            {
                if (this.ornaments[_i2] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.ornaments[_i2]) + ") on element 2 (starting at 1) of ornaments.")));
                };
                output.writeVarShort(this.ornaments[_i2]);
                _i2++;
            };
            if (this.activeTitle < 0)
            {
                throw (new Error((("Forbidden value (" + this.activeTitle) + ") on element activeTitle.")));
            };
            output.writeVarShort(this.activeTitle);
            if (this.activeOrnament < 0)
            {
                throw (new Error((("Forbidden value (" + this.activeOrnament) + ") on element activeOrnament.")));
            };
            output.writeVarShort(this.activeOrnament);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TitlesAndOrnamentsListMessage(input);
        }

        public function deserializeAs_TitlesAndOrnamentsListMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _val2:uint;
            var _titlesLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _titlesLen)
            {
                _val1 = input.readVarUhShort();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of titles.")));
                };
                this.titles.push(_val1);
                _i1++;
            };
            var _ornamentsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _ornamentsLen)
            {
                _val2 = input.readVarUhShort();
                if (_val2 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val2) + ") on elements of ornaments.")));
                };
                this.ornaments.push(_val2);
                _i2++;
            };
            this.activeTitle = input.readVarUhShort();
            if (this.activeTitle < 0)
            {
                throw (new Error((("Forbidden value (" + this.activeTitle) + ") on element of TitlesAndOrnamentsListMessage.activeTitle.")));
            };
            this.activeOrnament = input.readVarUhShort();
            if (this.activeOrnament < 0)
            {
                throw (new Error((("Forbidden value (" + this.activeOrnament) + ") on element of TitlesAndOrnamentsListMessage.activeOrnament.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.tinsel

