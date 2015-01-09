package com.ankamagames.dofus.network.messages.game.modificator
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AreaFightModificatorUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6493;

        private var _isInitialized:Boolean = false;
        public var spellPairId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6493);
        }

        public function initAreaFightModificatorUpdateMessage(spellPairId:int=0):AreaFightModificatorUpdateMessage
        {
            this.spellPairId = spellPairId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.spellPairId = 0;
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
            this.serializeAs_AreaFightModificatorUpdateMessage(output);
        }

        public function serializeAs_AreaFightModificatorUpdateMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.spellPairId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AreaFightModificatorUpdateMessage(input);
        }

        public function deserializeAs_AreaFightModificatorUpdateMessage(input:ICustomDataInput):void
        {
            this.spellPairId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.modificator

