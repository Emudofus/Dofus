package com.ankamagames.dofus.network.messages.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.house.HouseInformationsInside;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.house.HouseInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
    import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
    import com.ankamagames.dofus.network.types.game.interactive.StatedElement;
    import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
    import com.ankamagames.dofus.network.types.game.context.fight.FightCommonInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class MapComplementaryInformationsDataInHouseMessage extends MapComplementaryInformationsDataMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6130;

        private var _isInitialized:Boolean = false;
        public var currentHouse:HouseInformationsInside;

        public function MapComplementaryInformationsDataInHouseMessage()
        {
            this.currentHouse = new HouseInformationsInside();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6130);
        }

        public function initMapComplementaryInformationsDataInHouseMessage(subAreaId:uint=0, mapId:uint=0, houses:Vector.<HouseInformations>=null, actors:Vector.<GameRolePlayActorInformations>=null, interactiveElements:Vector.<InteractiveElement>=null, statedElements:Vector.<StatedElement>=null, obstacles:Vector.<MapObstacle>=null, fights:Vector.<FightCommonInformations>=null, currentHouse:HouseInformationsInside=null):MapComplementaryInformationsDataInHouseMessage
        {
            super.initMapComplementaryInformationsDataMessage(subAreaId, mapId, houses, actors, interactiveElements, statedElements, obstacles, fights);
            this.currentHouse = currentHouse;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.currentHouse = new HouseInformationsInside();
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_MapComplementaryInformationsDataInHouseMessage(output);
        }

        public function serializeAs_MapComplementaryInformationsDataInHouseMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_MapComplementaryInformationsDataMessage(output);
            this.currentHouse.serializeAs_HouseInformationsInside(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MapComplementaryInformationsDataInHouseMessage(input);
        }

        public function deserializeAs_MapComplementaryInformationsDataInHouseMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.currentHouse = new HouseInformationsInside();
            this.currentHouse.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay

