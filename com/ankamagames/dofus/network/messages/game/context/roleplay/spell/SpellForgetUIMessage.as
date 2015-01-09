package com.ankamagames.dofus.network.messages.game.context.roleplay.spell
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

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
            this.serializeAs_SpellForgetUIMessage(output);
        }

        public function serializeAs_SpellForgetUIMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.open);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_SpellForgetUIMessage(input);
        }

        public function deserializeAs_SpellForgetUIMessage(input:ICustomDataInput):void
        {
            this.open = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.spell

