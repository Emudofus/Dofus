package com.ankamagames.dofus.network.messages.game.prism
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.prism.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PrismWorldInformationMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var nbSubOwned:uint = 0;
        public var subTotal:uint = 0;
        public var maxSub:uint = 0;
        public var subAreasInformation:Vector.<PrismSubAreaInformation>;
        public var nbConqsOwned:uint = 0;
        public var conqsTotal:uint = 0;
        public var conquetesInformation:Vector.<VillageConquestPrismInformation>;
        public static const protocolId:uint = 5854;

        public function PrismWorldInformationMessage()
        {
            this.subAreasInformation = new Vector.<PrismSubAreaInformation>;
            this.conquetesInformation = new Vector.<VillageConquestPrismInformation>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5854;
        }// end function

        public function initPrismWorldInformationMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:Vector.<PrismSubAreaInformation> = null, param5:uint = 0, param6:uint = 0, param7:Vector.<VillageConquestPrismInformation> = null) : PrismWorldInformationMessage
        {
            this.nbSubOwned = param1;
            this.subTotal = param2;
            this.maxSub = param3;
            this.subAreasInformation = param4;
            this.nbConqsOwned = param5;
            this.conqsTotal = param6;
            this.conquetesInformation = param7;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.nbSubOwned = 0;
            this.subTotal = 0;
            this.maxSub = 0;
            this.subAreasInformation = new Vector.<PrismSubAreaInformation>;
            this.nbConqsOwned = 0;
            this.conqsTotal = 0;
            this.conquetesInformation = new Vector.<VillageConquestPrismInformation>;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_PrismWorldInformationMessage(param1);
            return;
        }// end function

        public function serializeAs_PrismWorldInformationMessage(param1:IDataOutput) : void
        {
            if (this.nbSubOwned < 0)
            {
                throw new Error("Forbidden value (" + this.nbSubOwned + ") on element nbSubOwned.");
            }
            param1.writeInt(this.nbSubOwned);
            if (this.subTotal < 0)
            {
                throw new Error("Forbidden value (" + this.subTotal + ") on element subTotal.");
            }
            param1.writeInt(this.subTotal);
            if (this.maxSub < 0)
            {
                throw new Error("Forbidden value (" + this.maxSub + ") on element maxSub.");
            }
            param1.writeInt(this.maxSub);
            param1.writeShort(this.subAreasInformation.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.subAreasInformation.length)
            {
                
                (this.subAreasInformation[_loc_2] as PrismSubAreaInformation).serializeAs_PrismSubAreaInformation(param1);
                _loc_2 = _loc_2 + 1;
            }
            if (this.nbConqsOwned < 0)
            {
                throw new Error("Forbidden value (" + this.nbConqsOwned + ") on element nbConqsOwned.");
            }
            param1.writeInt(this.nbConqsOwned);
            if (this.conqsTotal < 0)
            {
                throw new Error("Forbidden value (" + this.conqsTotal + ") on element conqsTotal.");
            }
            param1.writeInt(this.conqsTotal);
            param1.writeShort(this.conquetesInformation.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.conquetesInformation.length)
            {
                
                (this.conquetesInformation[_loc_3] as VillageConquestPrismInformation).serializeAs_VillageConquestPrismInformation(param1);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PrismWorldInformationMessage(param1);
            return;
        }// end function

        public function deserializeAs_PrismWorldInformationMessage(param1:IDataInput) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            this.nbSubOwned = param1.readInt();
            if (this.nbSubOwned < 0)
            {
                throw new Error("Forbidden value (" + this.nbSubOwned + ") on element of PrismWorldInformationMessage.nbSubOwned.");
            }
            this.subTotal = param1.readInt();
            if (this.subTotal < 0)
            {
                throw new Error("Forbidden value (" + this.subTotal + ") on element of PrismWorldInformationMessage.subTotal.");
            }
            this.maxSub = param1.readInt();
            if (this.maxSub < 0)
            {
                throw new Error("Forbidden value (" + this.maxSub + ") on element of PrismWorldInformationMessage.maxSub.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = new PrismSubAreaInformation();
                _loc_6.deserialize(param1);
                this.subAreasInformation.push(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            this.nbConqsOwned = param1.readInt();
            if (this.nbConqsOwned < 0)
            {
                throw new Error("Forbidden value (" + this.nbConqsOwned + ") on element of PrismWorldInformationMessage.nbConqsOwned.");
            }
            this.conqsTotal = param1.readInt();
            if (this.conqsTotal < 0)
            {
                throw new Error("Forbidden value (" + this.conqsTotal + ") on element of PrismWorldInformationMessage.conqsTotal.");
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = new VillageConquestPrismInformation();
                _loc_7.deserialize(param1);
                this.conquetesInformation.push(_loc_7);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
