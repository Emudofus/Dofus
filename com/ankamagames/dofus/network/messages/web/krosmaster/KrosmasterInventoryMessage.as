package com.ankamagames.dofus.network.messages.web.krosmaster
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.web.krosmaster.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class KrosmasterInventoryMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var figures:Vector.<KrosmasterFigure>;
        public static const protocolId:uint = 6350;

        public function KrosmasterInventoryMessage()
        {
            this.figures = new Vector.<KrosmasterFigure>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6350;
        }// end function

        public function initKrosmasterInventoryMessage(param1:Vector.<KrosmasterFigure> = null) : KrosmasterInventoryMessage
        {
            this.figures = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.figures = new Vector.<KrosmasterFigure>;
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
            this.serializeAs_KrosmasterInventoryMessage(param1);
            return;
        }// end function

        public function serializeAs_KrosmasterInventoryMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.figures.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.figures.length)
            {
                
                (this.figures[_loc_2] as KrosmasterFigure).serializeAs_KrosmasterFigure(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_KrosmasterInventoryMessage(param1);
            return;
        }// end function

        public function deserializeAs_KrosmasterInventoryMessage(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new KrosmasterFigure();
                _loc_4.deserialize(param1);
                this.figures.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
