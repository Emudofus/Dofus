package com.ankamagames.dofus.network.messages.game.context.roleplay
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.house.*;
    import com.ankamagames.dofus.network.types.game.interactive.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MapComplementaryInformationsDataMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var subAreaId:uint = 0;
        public var mapId:uint = 0;
        public var subareaAlignmentSide:int = 0;
        public var houses:Vector.<HouseInformations>;
        public var actors:Vector.<GameRolePlayActorInformations>;
        public var interactiveElements:Vector.<InteractiveElement>;
        public var statedElements:Vector.<StatedElement>;
        public var obstacles:Vector.<MapObstacle>;
        public var fights:Vector.<FightCommonInformations>;
        public static const protocolId:uint = 226;

        public function MapComplementaryInformationsDataMessage()
        {
            this.houses = new Vector.<HouseInformations>;
            this.actors = new Vector.<GameRolePlayActorInformations>;
            this.interactiveElements = new Vector.<InteractiveElement>;
            this.statedElements = new Vector.<StatedElement>;
            this.obstacles = new Vector.<MapObstacle>;
            this.fights = new Vector.<FightCommonInformations>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 226;
        }// end function

        public function initMapComplementaryInformationsDataMessage(param1:uint = 0, param2:uint = 0, param3:int = 0, param4:Vector.<HouseInformations> = null, param5:Vector.<GameRolePlayActorInformations> = null, param6:Vector.<InteractiveElement> = null, param7:Vector.<StatedElement> = null, param8:Vector.<MapObstacle> = null, param9:Vector.<FightCommonInformations> = null) : MapComplementaryInformationsDataMessage
        {
            this.subAreaId = param1;
            this.mapId = param2;
            this.subareaAlignmentSide = param3;
            this.houses = param4;
            this.actors = param5;
            this.interactiveElements = param6;
            this.statedElements = param7;
            this.obstacles = param8;
            this.fights = param9;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.subAreaId = 0;
            this.mapId = 0;
            this.subareaAlignmentSide = 0;
            this.houses = new Vector.<HouseInformations>;
            this.actors = new Vector.<GameRolePlayActorInformations>;
            this.interactiveElements = new Vector.<InteractiveElement>;
            this.statedElements = new Vector.<StatedElement>;
            this.obstacles = new Vector.<MapObstacle>;
            this.fights = new Vector.<FightCommonInformations>;
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
            this.serializeAs_MapComplementaryInformationsDataMessage(param1);
            return;
        }// end function

        public function serializeAs_MapComplementaryInformationsDataMessage(param1:IDataOutput) : void
        {
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
            }
            param1.writeShort(this.subAreaId);
            if (this.mapId < 0)
            {
                throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
            }
            param1.writeInt(this.mapId);
            param1.writeByte(this.subareaAlignmentSide);
            param1.writeShort(this.houses.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.houses.length)
            {
                
                param1.writeShort((this.houses[_loc_2] as HouseInformations).getTypeId());
                (this.houses[_loc_2] as HouseInformations).serialize(param1);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.actors.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.actors.length)
            {
                
                param1.writeShort((this.actors[_loc_3] as GameRolePlayActorInformations).getTypeId());
                (this.actors[_loc_3] as GameRolePlayActorInformations).serialize(param1);
                _loc_3 = _loc_3 + 1;
            }
            param1.writeShort(this.interactiveElements.length);
            var _loc_4:* = 0;
            while (_loc_4 < this.interactiveElements.length)
            {
                
                param1.writeShort((this.interactiveElements[_loc_4] as InteractiveElement).getTypeId());
                (this.interactiveElements[_loc_4] as InteractiveElement).serialize(param1);
                _loc_4 = _loc_4 + 1;
            }
            param1.writeShort(this.statedElements.length);
            var _loc_5:* = 0;
            while (_loc_5 < this.statedElements.length)
            {
                
                (this.statedElements[_loc_5] as StatedElement).serializeAs_StatedElement(param1);
                _loc_5 = _loc_5 + 1;
            }
            param1.writeShort(this.obstacles.length);
            var _loc_6:* = 0;
            while (_loc_6 < this.obstacles.length)
            {
                
                (this.obstacles[_loc_6] as MapObstacle).serializeAs_MapObstacle(param1);
                _loc_6 = _loc_6 + 1;
            }
            param1.writeShort(this.fights.length);
            var _loc_7:* = 0;
            while (_loc_7 < this.fights.length)
            {
                
                (this.fights[_loc_7] as FightCommonInformations).serializeAs_FightCommonInformations(param1);
                _loc_7 = _loc_7 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MapComplementaryInformationsDataMessage(param1);
            return;
        }// end function

        public function deserializeAs_MapComplementaryInformationsDataMessage(param1:IDataInput) : void
        {
            var _loc_14:* = 0;
            var _loc_15:* = null;
            var _loc_16:* = 0;
            var _loc_17:* = null;
            var _loc_18:* = 0;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            this.subAreaId = param1.readShort();
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element of MapComplementaryInformationsDataMessage.subAreaId.");
            }
            this.mapId = param1.readInt();
            if (this.mapId < 0)
            {
                throw new Error("Forbidden value (" + this.mapId + ") on element of MapComplementaryInformationsDataMessage.mapId.");
            }
            this.subareaAlignmentSide = param1.readByte();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_14 = param1.readUnsignedShort();
                _loc_15 = ProtocolTypeManager.getInstance(HouseInformations, _loc_14);
                _loc_15.deserialize(param1);
                this.houses.push(_loc_15);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_16 = param1.readUnsignedShort();
                _loc_17 = ProtocolTypeManager.getInstance(GameRolePlayActorInformations, _loc_16);
                _loc_17.deserialize(param1);
                this.actors.push(_loc_17);
                _loc_5 = _loc_5 + 1;
            }
            var _loc_6:* = param1.readUnsignedShort();
            var _loc_7:* = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_18 = param1.readUnsignedShort();
                _loc_19 = ProtocolTypeManager.getInstance(InteractiveElement, _loc_18);
                _loc_19.deserialize(param1);
                this.interactiveElements.push(_loc_19);
                _loc_7 = _loc_7 + 1;
            }
            var _loc_8:* = param1.readUnsignedShort();
            var _loc_9:* = 0;
            while (_loc_9 < _loc_8)
            {
                
                _loc_20 = new StatedElement();
                _loc_20.deserialize(param1);
                this.statedElements.push(_loc_20);
                _loc_9 = _loc_9 + 1;
            }
            var _loc_10:* = param1.readUnsignedShort();
            var _loc_11:* = 0;
            while (_loc_11 < _loc_10)
            {
                
                _loc_21 = new MapObstacle();
                _loc_21.deserialize(param1);
                this.obstacles.push(_loc_21);
                _loc_11 = _loc_11 + 1;
            }
            var _loc_12:* = param1.readUnsignedShort();
            var _loc_13:* = 0;
            while (_loc_13 < _loc_12)
            {
                
                _loc_22 = new FightCommonInformations();
                _loc_22.deserialize(param1);
                this.fights.push(_loc_22);
                _loc_13 = _loc_13 + 1;
            }
            return;
        }// end function

    }
}
