package com.ankamagames.dofus.network.messages.game.context.roleplay
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.house.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MapComplementaryInformationsDataInHouseMessage extends MapComplementaryInformationsDataMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var currentHouse:HouseInformationsInside;
        public static const protocolId:uint = 6130;

        public function MapComplementaryInformationsDataInHouseMessage()
        {
            this.currentHouse = new HouseInformationsInside();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6130;
        }// end function

        public function initMapComplementaryInformationsDataInHouseMessage(param1:uint = 0, param2:uint = 0, param3:int = 0, param4:Vector.<HouseInformations> = null, param5:Vector.<GameRolePlayActorInformations> = null, param6:Vector.<InteractiveElement> = null, param7:Vector.<StatedElement> = null, param8:Vector.<MapObstacle> = null, param9:Vector.<FightCommonInformations> = null, param10:HouseInformationsInside = null) : MapComplementaryInformationsDataInHouseMessage
        {
            super.initMapComplementaryInformationsDataMessage(param1, param2, param3, param4, param5, param6, param7, param8, param9);
            this.currentHouse = param10;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.currentHouse = new HouseInformationsInside();
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_MapComplementaryInformationsDataInHouseMessage(param1);
            return;
        }// end function

        public function serializeAs_MapComplementaryInformationsDataInHouseMessage(param1:IDataOutput) : void
        {
            super.serializeAs_MapComplementaryInformationsDataMessage(param1);
            this.currentHouse.serializeAs_HouseInformationsInside(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MapComplementaryInformationsDataInHouseMessage(param1);
            return;
        }// end function

        public function deserializeAs_MapComplementaryInformationsDataInHouseMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.currentHouse = new HouseInformationsInside();
            this.currentHouse.deserialize(param1);
            return;
        }// end function

    }
}
