package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.house.HouseInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.dofus.network.types.game.interactive.StatedElement;
   import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
   import com.ankamagames.dofus.network.types.game.context.fight.FightCommonInformations;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class MapComplementaryInformationsDataMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MapComplementaryInformationsDataMessage() {
         this.houses = new Vector.<HouseInformations>();
         this.actors = new Vector.<GameRolePlayActorInformations>();
         this.interactiveElements = new Vector.<InteractiveElement>();
         this.statedElements = new Vector.<StatedElement>();
         this.obstacles = new Vector.<MapObstacle>();
         this.fights = new Vector.<FightCommonInformations>();
         super();
      }
      
      public static const protocolId:uint = 226;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var subAreaId:uint = 0;
      
      public var mapId:uint = 0;
      
      public var houses:Vector.<HouseInformations>;
      
      public var actors:Vector.<GameRolePlayActorInformations>;
      
      public var interactiveElements:Vector.<InteractiveElement>;
      
      public var statedElements:Vector.<StatedElement>;
      
      public var obstacles:Vector.<MapObstacle>;
      
      public var fights:Vector.<FightCommonInformations>;
      
      override public function getMessageId() : uint {
         return 226;
      }
      
      public function initMapComplementaryInformationsDataMessage(subAreaId:uint=0, mapId:uint=0, houses:Vector.<HouseInformations>=null, actors:Vector.<GameRolePlayActorInformations>=null, interactiveElements:Vector.<InteractiveElement>=null, statedElements:Vector.<StatedElement>=null, obstacles:Vector.<MapObstacle>=null, fights:Vector.<FightCommonInformations>=null) : MapComplementaryInformationsDataMessage {
         this.subAreaId = subAreaId;
         this.mapId = mapId;
         this.houses = houses;
         this.actors = actors;
         this.interactiveElements = interactiveElements;
         this.statedElements = statedElements;
         this.obstacles = obstacles;
         this.fights = fights;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.subAreaId = 0;
         this.mapId = 0;
         this.houses = new Vector.<HouseInformations>();
         this.actors = new Vector.<GameRolePlayActorInformations>();
         this.interactiveElements = new Vector.<InteractiveElement>();
         this.statedElements = new Vector.<StatedElement>();
         this.obstacles = new Vector.<MapObstacle>();
         this.fights = new Vector.<FightCommonInformations>();
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_MapComplementaryInformationsDataMessage(output);
      }
      
      public function serializeAs_MapComplementaryInformationsDataMessage(output:IDataOutput) : void {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            output.writeShort(this.subAreaId);
            if(this.mapId < 0)
            {
               throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
            }
            else
            {
               output.writeInt(this.mapId);
               output.writeShort(this.houses.length);
               _i3 = 0;
               while(_i3 < this.houses.length)
               {
                  output.writeShort((this.houses[_i3] as HouseInformations).getTypeId());
                  (this.houses[_i3] as HouseInformations).serialize(output);
                  _i3++;
               }
               output.writeShort(this.actors.length);
               _i4 = 0;
               while(_i4 < this.actors.length)
               {
                  output.writeShort((this.actors[_i4] as GameRolePlayActorInformations).getTypeId());
                  (this.actors[_i4] as GameRolePlayActorInformations).serialize(output);
                  _i4++;
               }
               output.writeShort(this.interactiveElements.length);
               _i5 = 0;
               while(_i5 < this.interactiveElements.length)
               {
                  output.writeShort((this.interactiveElements[_i5] as InteractiveElement).getTypeId());
                  (this.interactiveElements[_i5] as InteractiveElement).serialize(output);
                  _i5++;
               }
               output.writeShort(this.statedElements.length);
               _i6 = 0;
               while(_i6 < this.statedElements.length)
               {
                  (this.statedElements[_i6] as StatedElement).serializeAs_StatedElement(output);
                  _i6++;
               }
               output.writeShort(this.obstacles.length);
               _i7 = 0;
               while(_i7 < this.obstacles.length)
               {
                  (this.obstacles[_i7] as MapObstacle).serializeAs_MapObstacle(output);
                  _i7++;
               }
               output.writeShort(this.fights.length);
               _i8 = 0;
               while(_i8 < this.fights.length)
               {
                  (this.fights[_i8] as FightCommonInformations).serializeAs_FightCommonInformations(output);
                  _i8++;
               }
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MapComplementaryInformationsDataMessage(input);
      }
      
      public function deserializeAs_MapComplementaryInformationsDataMessage(input:IDataInput) : void {
         var _id3:uint = 0;
         var _item3:HouseInformations = null;
         var _id4:uint = 0;
         var _item4:GameRolePlayActorInformations = null;
         var _id5:uint = 0;
         var _item5:InteractiveElement = null;
         var _item6:StatedElement = null;
         var _item7:MapObstacle = null;
         var _item8:FightCommonInformations = null;
         this.subAreaId = input.readShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of MapComplementaryInformationsDataMessage.subAreaId.");
         }
         else
         {
            this.mapId = input.readInt();
            if(this.mapId < 0)
            {
               throw new Error("Forbidden value (" + this.mapId + ") on element of MapComplementaryInformationsDataMessage.mapId.");
            }
            else
            {
               _housesLen = input.readUnsignedShort();
               _i3 = 0;
               while(_i3 < _housesLen)
               {
                  _id3 = input.readUnsignedShort();
                  _item3 = ProtocolTypeManager.getInstance(HouseInformations,_id3);
                  _item3.deserialize(input);
                  this.houses.push(_item3);
                  _i3++;
               }
               _actorsLen = input.readUnsignedShort();
               _i4 = 0;
               while(_i4 < _actorsLen)
               {
                  _id4 = input.readUnsignedShort();
                  _item4 = ProtocolTypeManager.getInstance(GameRolePlayActorInformations,_id4);
                  _item4.deserialize(input);
                  this.actors.push(_item4);
                  _i4++;
               }
               _interactiveElementsLen = input.readUnsignedShort();
               _i5 = 0;
               while(_i5 < _interactiveElementsLen)
               {
                  _id5 = input.readUnsignedShort();
                  _item5 = ProtocolTypeManager.getInstance(InteractiveElement,_id5);
                  _item5.deserialize(input);
                  this.interactiveElements.push(_item5);
                  _i5++;
               }
               _statedElementsLen = input.readUnsignedShort();
               _i6 = 0;
               while(_i6 < _statedElementsLen)
               {
                  _item6 = new StatedElement();
                  _item6.deserialize(input);
                  this.statedElements.push(_item6);
                  _i6++;
               }
               _obstaclesLen = input.readUnsignedShort();
               _i7 = 0;
               while(_i7 < _obstaclesLen)
               {
                  _item7 = new MapObstacle();
                  _item7.deserialize(input);
                  this.obstacles.push(_item7);
                  _i7++;
               }
               _fightsLen = input.readUnsignedShort();
               _i8 = 0;
               while(_i8 < _fightsLen)
               {
                  _item8 = new FightCommonInformations();
                  _item8.deserialize(input);
                  this.fights.push(_item8);
                  _i8++;
               }
               return;
            }
         }
      }
   }
}
