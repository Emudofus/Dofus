package com.ankamagames.dofus.network.messages.web.krosmaster
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.web.krosmaster.KrosmasterFigure;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class KrosmasterInventoryMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6350;

        private var _isInitialized:Boolean = false;
        public var figures:Vector.<KrosmasterFigure>;

        public function KrosmasterInventoryMessage()
        {
            this.figures = new Vector.<KrosmasterFigure>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6350);
        }

        public function initKrosmasterInventoryMessage(figures:Vector.<KrosmasterFigure>=null):KrosmasterInventoryMessage
        {
            this.figures = figures;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.figures = new Vector.<KrosmasterFigure>();
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
            this.serializeAs_KrosmasterInventoryMessage(output);
        }

        public function serializeAs_KrosmasterInventoryMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.figures.length);
            var _i1:uint;
            while (_i1 < this.figures.length)
            {
                (this.figures[_i1] as KrosmasterFigure).serializeAs_KrosmasterFigure(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_KrosmasterInventoryMessage(input);
        }

        public function deserializeAs_KrosmasterInventoryMessage(input:ICustomDataInput):void
        {
            var _item1:KrosmasterFigure;
            var _figuresLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _figuresLen)
            {
                _item1 = new KrosmasterFigure();
                _item1.deserialize(input);
                this.figures.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.web.krosmaster

