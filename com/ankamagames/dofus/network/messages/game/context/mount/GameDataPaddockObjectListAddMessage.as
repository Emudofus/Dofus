package com.ankamagames.dofus.network.messages.game.context.mount
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.paddock.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameDataPaddockObjectListAddMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var paddockItemDescription:Vector.<PaddockItem>;
        public static const protocolId:uint = 5992;

        public function GameDataPaddockObjectListAddMessage()
        {
            this.paddockItemDescription = new Vector.<PaddockItem>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5992;
        }// end function

        public function initGameDataPaddockObjectListAddMessage(param1:Vector.<PaddockItem> = null) : GameDataPaddockObjectListAddMessage
        {
            this.paddockItemDescription = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.paddockItemDescription = new Vector.<PaddockItem>;
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
            this.serializeAs_GameDataPaddockObjectListAddMessage(param1);
            return;
        }// end function

        public function serializeAs_GameDataPaddockObjectListAddMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.paddockItemDescription.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.paddockItemDescription.length)
            {
                
                (this.paddockItemDescription[_loc_2] as PaddockItem).serializeAs_PaddockItem(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameDataPaddockObjectListAddMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameDataPaddockObjectListAddMessage(param1:IDataInput) : void
        {
            var _loc_4:PaddockItem = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new PaddockItem();
                _loc_4.deserialize(param1);
                this.paddockItemDescription.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
