package com.ankamagames.dofus.network.messages.game.guild.tax
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.guild.tax.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TaxCollectorListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var nbcollectorMax:uint = 0;
        public var taxCollectorHireCost:uint = 0;
        public var informations:Vector.<TaxCollectorInformations>;
        public var fightersInformations:Vector.<TaxCollectorFightersInformation>;
        public static const protocolId:uint = 5930;

        public function TaxCollectorListMessage()
        {
            this.informations = new Vector.<TaxCollectorInformations>;
            this.fightersInformations = new Vector.<TaxCollectorFightersInformation>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5930;
        }// end function

        public function initTaxCollectorListMessage(param1:uint = 0, param2:uint = 0, param3:Vector.<TaxCollectorInformations> = null, param4:Vector.<TaxCollectorFightersInformation> = null) : TaxCollectorListMessage
        {
            this.nbcollectorMax = param1;
            this.taxCollectorHireCost = param2;
            this.informations = param3;
            this.fightersInformations = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.nbcollectorMax = 0;
            this.taxCollectorHireCost = 0;
            this.informations = new Vector.<TaxCollectorInformations>;
            this.fightersInformations = new Vector.<TaxCollectorFightersInformation>;
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
            this.serializeAs_TaxCollectorListMessage(param1);
            return;
        }// end function

        public function serializeAs_TaxCollectorListMessage(param1:IDataOutput) : void
        {
            if (this.nbcollectorMax < 0)
            {
                throw new Error("Forbidden value (" + this.nbcollectorMax + ") on element nbcollectorMax.");
            }
            param1.writeByte(this.nbcollectorMax);
            if (this.taxCollectorHireCost < 0)
            {
                throw new Error("Forbidden value (" + this.taxCollectorHireCost + ") on element taxCollectorHireCost.");
            }
            param1.writeShort(this.taxCollectorHireCost);
            param1.writeShort(this.informations.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.informations.length)
            {
                
                param1.writeShort((this.informations[_loc_2] as TaxCollectorInformations).getTypeId());
                (this.informations[_loc_2] as TaxCollectorInformations).serialize(param1);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.fightersInformations.length);
            var _loc_3:uint = 0;
            while (_loc_3 < this.fightersInformations.length)
            {
                
                (this.fightersInformations[_loc_3] as TaxCollectorFightersInformation).serializeAs_TaxCollectorFightersInformation(param1);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TaxCollectorListMessage(param1);
            return;
        }// end function

        public function deserializeAs_TaxCollectorListMessage(param1:IDataInput) : void
        {
            var _loc_6:uint = 0;
            var _loc_7:TaxCollectorInformations = null;
            var _loc_8:TaxCollectorFightersInformation = null;
            this.nbcollectorMax = param1.readByte();
            if (this.nbcollectorMax < 0)
            {
                throw new Error("Forbidden value (" + this.nbcollectorMax + ") on element of TaxCollectorListMessage.nbcollectorMax.");
            }
            this.taxCollectorHireCost = param1.readShort();
            if (this.taxCollectorHireCost < 0)
            {
                throw new Error("Forbidden value (" + this.taxCollectorHireCost + ") on element of TaxCollectorListMessage.taxCollectorHireCost.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = param1.readUnsignedShort();
                _loc_7 = ProtocolTypeManager.getInstance(TaxCollectorInformations, _loc_6);
                _loc_7.deserialize(param1);
                this.informations.push(_loc_7);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:uint = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_8 = new TaxCollectorFightersInformation();
                _loc_8.deserialize(param1);
                this.fightersInformations.push(_loc_8);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
