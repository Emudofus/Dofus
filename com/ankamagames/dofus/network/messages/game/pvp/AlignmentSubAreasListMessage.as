package com.ankamagames.dofus.network.messages.game.pvp
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AlignmentSubAreasListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var angelsSubAreas:Vector.<int>;
        public var evilsSubAreas:Vector.<int>;
        public static const protocolId:uint = 6059;

        public function AlignmentSubAreasListMessage()
        {
            this.angelsSubAreas = new Vector.<int>;
            this.evilsSubAreas = new Vector.<int>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6059;
        }// end function

        public function initAlignmentSubAreasListMessage(param1:Vector.<int> = null, param2:Vector.<int> = null) : AlignmentSubAreasListMessage
        {
            this.angelsSubAreas = param1;
            this.evilsSubAreas = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.angelsSubAreas = new Vector.<int>;
            this.evilsSubAreas = new Vector.<int>;
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
            this.serializeAs_AlignmentSubAreasListMessage(param1);
            return;
        }// end function

        public function serializeAs_AlignmentSubAreasListMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.angelsSubAreas.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.angelsSubAreas.length)
            {
                
                param1.writeShort(this.angelsSubAreas[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.evilsSubAreas.length);
            var _loc_3:uint = 0;
            while (_loc_3 < this.evilsSubAreas.length)
            {
                
                param1.writeShort(this.evilsSubAreas[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AlignmentSubAreasListMessage(param1);
            return;
        }// end function

        public function deserializeAs_AlignmentSubAreasListMessage(param1:IDataInput) : void
        {
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = param1.readShort();
                this.angelsSubAreas.push(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:uint = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = param1.readShort();
                this.evilsSubAreas.push(_loc_7);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
