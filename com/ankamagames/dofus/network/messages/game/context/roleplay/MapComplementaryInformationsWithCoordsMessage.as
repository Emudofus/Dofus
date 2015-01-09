package com.ankamagames.dofus.network.messages.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.house.HouseInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
    import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
    import com.ankamagames.dofus.network.types.game.interactive.StatedElement;
    import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
    import com.ankamagames.dofus.network.types.game.context.fight.FightCommonInformations;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class MapComplementaryInformationsWithCoordsMessage extends MapComplementaryInformationsDataMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6268;

        private var _isInitialized:Boolean = false;
        public var worldX:int = 0;
        public var worldY:int = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6268);
        }

        public function initMapComplementaryInformationsWithCoordsMessage(subAreaId:uint=0, mapId:uint=0, houses:Vector.<HouseInformations>=null, actors:Vector.<GameRolePlayActorInformations>=null, interactiveElements:Vector.<InteractiveElement>=null, statedElements:Vector.<StatedElement>=null, obstacles:Vector.<MapObstacle>=null, fights:Vector.<FightCommonInformations>=null, worldX:int=0, worldY:int=0):MapComplementaryInformationsWithCoordsMessage
        {
            super.initMapComplementaryInformationsDataMessage(subAreaId, mapId, houses, actors, interactiveElements, statedElements, obstacles, fights);
            this.worldX = worldX;
            this.worldY = worldY;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.worldX = 0;
            this.worldY = 0;
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

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_MapComplementaryInformationsWithCoordsMessage(output);
        }

        public function serializeAs_MapComplementaryInformationsWithCoordsMessage(output:IDataOutput):void
        {
            super.serializeAs_MapComplementaryInformationsDataMessage(output);
            if ((((this.worldX < -255)) || ((this.worldX > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldX) + ") on element worldX.")));
            };
            output.writeShort(this.worldX);
            if ((((this.worldY < -255)) || ((this.worldY > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldY) + ") on element worldY.")));
            };
            output.writeShort(this.worldY);
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_MapComplementaryInformationsWithCoordsMessage(input);
        }

        public function deserializeAs_MapComplementaryInformationsWithCoordsMessage(input:IDataInput):void
        {
            super.deserialize(input);
            this.worldX = input.readShort();
            if ((((this.worldX < -255)) || ((this.worldX > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldX) + ") on element of MapComplementaryInformationsWithCoordsMessage.worldX.")));
            };
            this.worldY = input.readShort();
            if ((((this.worldY < -255)) || ((this.worldY > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldY) + ") on element of MapComplementaryInformationsWithCoordsMessage.worldY.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay

