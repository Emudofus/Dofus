package com.ankamagames.dofus.network.messages.game.prism
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.prism.PrismFightersInformation;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class PrismsInfoValidMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6451;

        private var _isInitialized:Boolean = false;
        public var fights:Vector.<PrismFightersInformation>;

        public function PrismsInfoValidMessage()
        {
            this.fights = new Vector.<PrismFightersInformation>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6451);
        }

        public function initPrismsInfoValidMessage(fights:Vector.<PrismFightersInformation>=null):PrismsInfoValidMessage
        {
            this.fights = fights;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.fights = new Vector.<PrismFightersInformation>();
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
            this.serializeAs_PrismsInfoValidMessage(output);
        }

        public function serializeAs_PrismsInfoValidMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.fights.length);
            var _i1:uint;
            while (_i1 < this.fights.length)
            {
                (this.fights[_i1] as PrismFightersInformation).serializeAs_PrismFightersInformation(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PrismsInfoValidMessage(input);
        }

        public function deserializeAs_PrismsInfoValidMessage(input:ICustomDataInput):void
        {
            var _item1:PrismFightersInformation;
            var _fightsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _fightsLen)
            {
                _item1 = new PrismFightersInformation();
                _item1.deserialize(input);
                this.fights.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.prism

