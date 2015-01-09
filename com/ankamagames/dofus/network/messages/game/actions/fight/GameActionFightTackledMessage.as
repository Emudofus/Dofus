package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class GameActionFightTackledMessage extends AbstractGameActionMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 1004;

        private var _isInitialized:Boolean = false;
        public var tacklersIds:Vector.<int>;

        public function GameActionFightTackledMessage()
        {
            this.tacklersIds = new Vector.<int>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (1004);
        }

        public function initGameActionFightTackledMessage(actionId:uint=0, sourceId:int=0, tacklersIds:Vector.<int>=null):GameActionFightTackledMessage
        {
            super.initAbstractGameActionMessage(actionId, sourceId);
            this.tacklersIds = tacklersIds;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.tacklersIds = new Vector.<int>();
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameActionFightTackledMessage(output);
        }

        public function serializeAs_GameActionFightTackledMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractGameActionMessage(output);
            output.writeShort(this.tacklersIds.length);
            var _i1:uint;
            while (_i1 < this.tacklersIds.length)
            {
                output.writeInt(this.tacklersIds[_i1]);
                _i1++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameActionFightTackledMessage(input);
        }

        public function deserializeAs_GameActionFightTackledMessage(input:ICustomDataInput):void
        {
            var _val1:int;
            super.deserialize(input);
            var _tacklersIdsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _tacklersIdsLen)
            {
                _val1 = input.readInt();
                this.tacklersIds.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.actions.fight

