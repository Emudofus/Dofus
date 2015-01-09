package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    [Trusted]
    public class SetUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5503;

        private var _isInitialized:Boolean = false;
        public var setId:uint = 0;
        public var setObjects:Vector.<uint>;
        public var setEffects:Vector.<ObjectEffect>;

        public function SetUpdateMessage()
        {
            this.setObjects = new Vector.<uint>();
            this.setEffects = new Vector.<ObjectEffect>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5503);
        }

        public function initSetUpdateMessage(setId:uint=0, setObjects:Vector.<uint>=null, setEffects:Vector.<ObjectEffect>=null):SetUpdateMessage
        {
            this.setId = setId;
            this.setObjects = setObjects;
            this.setEffects = setEffects;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.setId = 0;
            this.setObjects = new Vector.<uint>();
            this.setEffects = new Vector.<ObjectEffect>();
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
            this.serializeAs_SetUpdateMessage(output);
        }

        public function serializeAs_SetUpdateMessage(output:ICustomDataOutput):void
        {
            if (this.setId < 0)
            {
                throw (new Error((("Forbidden value (" + this.setId) + ") on element setId.")));
            };
            output.writeVarShort(this.setId);
            output.writeShort(this.setObjects.length);
            var _i2:uint;
            while (_i2 < this.setObjects.length)
            {
                if (this.setObjects[_i2] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.setObjects[_i2]) + ") on element 2 (starting at 1) of setObjects.")));
                };
                output.writeVarShort(this.setObjects[_i2]);
                _i2++;
            };
            output.writeShort(this.setEffects.length);
            var _i3:uint;
            while (_i3 < this.setEffects.length)
            {
                output.writeShort((this.setEffects[_i3] as ObjectEffect).getTypeId());
                (this.setEffects[_i3] as ObjectEffect).serialize(output);
                _i3++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_SetUpdateMessage(input);
        }

        public function deserializeAs_SetUpdateMessage(input:ICustomDataInput):void
        {
            var _val2:uint;
            var _id3:uint;
            var _item3:ObjectEffect;
            this.setId = input.readVarUhShort();
            if (this.setId < 0)
            {
                throw (new Error((("Forbidden value (" + this.setId) + ") on element of SetUpdateMessage.setId.")));
            };
            var _setObjectsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _setObjectsLen)
            {
                _val2 = input.readVarUhShort();
                if (_val2 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val2) + ") on elements of setObjects.")));
                };
                this.setObjects.push(_val2);
                _i2++;
            };
            var _setEffectsLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _setEffectsLen)
            {
                _id3 = input.readUnsignedShort();
                _item3 = ProtocolTypeManager.getInstance(ObjectEffect, _id3);
                _item3.deserialize(input);
                this.setEffects.push(_item3);
                _i3++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

