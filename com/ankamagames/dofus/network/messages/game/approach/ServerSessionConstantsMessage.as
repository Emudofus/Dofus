package com.ankamagames.dofus.network.messages.game.approach
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.approach.ServerSessionConstant;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    [Trusted]
    public class ServerSessionConstantsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6434;

        private var _isInitialized:Boolean = false;
        public var variables:Vector.<ServerSessionConstant>;

        public function ServerSessionConstantsMessage()
        {
            this.variables = new Vector.<ServerSessionConstant>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6434);
        }

        public function initServerSessionConstantsMessage(variables:Vector.<ServerSessionConstant>=null):ServerSessionConstantsMessage
        {
            this.variables = variables;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.variables = new Vector.<ServerSessionConstant>();
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
            this.serializeAs_ServerSessionConstantsMessage(output);
        }

        public function serializeAs_ServerSessionConstantsMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.variables.length);
            var _i1:uint;
            while (_i1 < this.variables.length)
            {
                output.writeShort((this.variables[_i1] as ServerSessionConstant).getTypeId());
                (this.variables[_i1] as ServerSessionConstant).serialize(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ServerSessionConstantsMessage(input);
        }

        public function deserializeAs_ServerSessionConstantsMessage(input:ICustomDataInput):void
        {
            var _id1:uint;
            var _item1:ServerSessionConstant;
            var _variablesLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _variablesLen)
            {
                _id1 = input.readUnsignedShort();
                _item1 = ProtocolTypeManager.getInstance(ServerSessionConstant, _id1);
                _item1.deserialize(input);
                this.variables.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.approach

