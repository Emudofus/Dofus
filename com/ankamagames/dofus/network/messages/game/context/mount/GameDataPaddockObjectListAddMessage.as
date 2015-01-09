package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.paddock.PaddockItem;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class GameDataPaddockObjectListAddMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5992;

        private var _isInitialized:Boolean = false;
        public var paddockItemDescription:Vector.<PaddockItem>;

        public function GameDataPaddockObjectListAddMessage()
        {
            this.paddockItemDescription = new Vector.<PaddockItem>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5992);
        }

        public function initGameDataPaddockObjectListAddMessage(paddockItemDescription:Vector.<PaddockItem>=null):GameDataPaddockObjectListAddMessage
        {
            this.paddockItemDescription = paddockItemDescription;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.paddockItemDescription = new Vector.<PaddockItem>();
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
            this.serializeAs_GameDataPaddockObjectListAddMessage(output);
        }

        public function serializeAs_GameDataPaddockObjectListAddMessage(output:IDataOutput):void
        {
            output.writeShort(this.paddockItemDescription.length);
            var _i1:uint;
            while (_i1 < this.paddockItemDescription.length)
            {
                (this.paddockItemDescription[_i1] as PaddockItem).serializeAs_PaddockItem(output);
                _i1++;
            };
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_GameDataPaddockObjectListAddMessage(input);
        }

        public function deserializeAs_GameDataPaddockObjectListAddMessage(input:IDataInput):void
        {
            var _item1:PaddockItem;
            var _paddockItemDescriptionLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _paddockItemDescriptionLen)
            {
                _item1 = new PaddockItem();
                _item1.deserialize(input);
                this.paddockItemDescription.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.mount

