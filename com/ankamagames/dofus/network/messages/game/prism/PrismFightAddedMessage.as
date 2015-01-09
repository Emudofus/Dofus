package com.ankamagames.dofus.network.messages.game.prism
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.prism.PrismFightersInformation;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PrismFightAddedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6452;

        private var _isInitialized:Boolean = false;
        public var fight:PrismFightersInformation;

        public function PrismFightAddedMessage()
        {
            this.fight = new PrismFightersInformation();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6452);
        }

        public function initPrismFightAddedMessage(fight:PrismFightersInformation=null):PrismFightAddedMessage
        {
            this.fight = fight;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.fight = new PrismFightersInformation();
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
            this.serializeAs_PrismFightAddedMessage(output);
        }

        public function serializeAs_PrismFightAddedMessage(output:ICustomDataOutput):void
        {
            this.fight.serializeAs_PrismFightersInformation(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PrismFightAddedMessage(input);
        }

        public function deserializeAs_PrismFightAddedMessage(input:ICustomDataInput):void
        {
            this.fight = new PrismFightersInformation();
            this.fight.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.prism

