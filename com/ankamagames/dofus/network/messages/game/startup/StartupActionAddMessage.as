package com.ankamagames.dofus.network.messages.game.startup
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.startup.StartupActionAddObject;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class StartupActionAddMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6538;

        private var _isInitialized:Boolean = false;
        public var newAction:StartupActionAddObject;

        public function StartupActionAddMessage()
        {
            this.newAction = new StartupActionAddObject();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6538);
        }

        public function initStartupActionAddMessage(newAction:StartupActionAddObject=null):StartupActionAddMessage
        {
            this.newAction = newAction;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.newAction = new StartupActionAddObject();
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
            this.serializeAs_StartupActionAddMessage(output);
        }

        public function serializeAs_StartupActionAddMessage(output:ICustomDataOutput):void
        {
            this.newAction.serializeAs_StartupActionAddObject(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_StartupActionAddMessage(input);
        }

        public function deserializeAs_StartupActionAddMessage(input:ICustomDataInput):void
        {
            this.newAction = new StartupActionAddObject();
            this.newAction.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.startup

