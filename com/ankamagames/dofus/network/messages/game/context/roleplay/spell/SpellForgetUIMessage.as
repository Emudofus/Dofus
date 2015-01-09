package com.ankamagames.dofus.network.messages.game.context.roleplay.spell
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class SpellForgetUIMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5565;

        private var _isInitialized:Boolean = false;
        public var open:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5565);
        }

        public function initSpellForgetUIMessage(open:Boolean=false):SpellForgetUIMessage
        {
            this.open = open;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.open = false;
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
            this.serializeAs_SpellForgetUIMessage(output);
        }

        public function serializeAs_SpellForgetUIMessage(output:IDataOutput):void
        {
            output.writeBoolean(this.open);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_SpellForgetUIMessage(input);
        }

        public function deserializeAs_SpellForgetUIMessage(input:IDataInput):void
        {
            this.open = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.spell

