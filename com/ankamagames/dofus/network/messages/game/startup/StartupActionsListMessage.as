package com.ankamagames.dofus.network.messages.game.startup
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.startup.StartupActionAddObject;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class StartupActionsListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 1301;

        private var _isInitialized:Boolean = false;
        public var actions:Vector.<StartupActionAddObject>;

        public function StartupActionsListMessage()
        {
            this.actions = new Vector.<StartupActionAddObject>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (1301);
        }

        public function initStartupActionsListMessage(actions:Vector.<StartupActionAddObject>=null):StartupActionsListMessage
        {
            this.actions = actions;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.actions = new Vector.<StartupActionAddObject>();
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
            this.serializeAs_StartupActionsListMessage(output);
        }

        public function serializeAs_StartupActionsListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.actions.length);
            var _i1:uint;
            while (_i1 < this.actions.length)
            {
                (this.actions[_i1] as StartupActionAddObject).serializeAs_StartupActionAddObject(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_StartupActionsListMessage(input);
        }

        public function deserializeAs_StartupActionsListMessage(input:ICustomDataInput):void
        {
            var _item1:StartupActionAddObject;
            var _actionsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _actionsLen)
            {
                _item1 = new StartupActionAddObject();
                _item1.deserialize(input);
                this.actions.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.startup

