package com.ankamagames.dofus.network.messages.game.prism
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.prism.PrismSubareaEmptyInfo;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    [Trusted]
    public class PrismsListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6440;

        private var _isInitialized:Boolean = false;
        public var prisms:Vector.<PrismSubareaEmptyInfo>;

        public function PrismsListMessage()
        {
            this.prisms = new Vector.<PrismSubareaEmptyInfo>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6440);
        }

        public function initPrismsListMessage(prisms:Vector.<PrismSubareaEmptyInfo>=null):PrismsListMessage
        {
            this.prisms = prisms;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.prisms = new Vector.<PrismSubareaEmptyInfo>();
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_PrismsListMessage(output);
        }

        public function serializeAs_PrismsListMessage(output:IDataOutput):void
        {
            output.writeShort(this.prisms.length);
            var _i1:uint;
            while (_i1 < this.prisms.length)
            {
                output.writeShort((this.prisms[_i1] as PrismSubareaEmptyInfo).getTypeId());
                (this.prisms[_i1] as PrismSubareaEmptyInfo).serialize(output);
                _i1++;
            };
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_PrismsListMessage(input);
        }

        public function deserializeAs_PrismsListMessage(input:IDataInput):void
        {
            var _id1:uint;
            var _item1:PrismSubareaEmptyInfo;
            var _prismsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _prismsLen)
            {
                _id1 = input.readUnsignedShort();
                _item1 = ProtocolTypeManager.getInstance(PrismSubareaEmptyInfo, _id1);
                _item1.deserialize(input);
                this.prisms.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.prism

