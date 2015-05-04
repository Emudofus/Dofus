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
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class MapComplementaryInformationsDataMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MapComplementaryInformationsDataMessage()
      {
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
      
      override public function get isInitialized() : Boolean
      {
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
      
      override public function getMessageId() : uint
      {
         return 226;
      }
      
      public function initMapComplementaryInformationsDataMessage(param1:uint = 0, param2:uint = 0, param3:Vector.<HouseInformations> = null, param4:Vector.<GameRolePlayActorInformations> = null, param5:Vector.<InteractiveElement> = null, param6:Vector.<StatedElement> = null, param7:Vector.<MapObstacle> = null, param8:Vector.<FightCommonInformations> = null) : MapComplementaryInformationsDataMessage
      {
         this.subAreaId = param1;
         this.mapId = param2;
         this.houses = param3;
         this.actors = param4;
         this.interactiveElements = param5;
         this.statedElements = param6;
         this.obstacles = param7;
         this.fights = param8;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
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
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_MapComplementaryInformationsDataMessage(param1);
      }
      
      public function serializeAs_MapComplementaryInformationsDataMessage(param1:ICustomDataOutput) : void
      {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            param1.writeVarShort(this.subAreaId);
            if(this.mapId < 0)
            {
               throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
            }
            else
            {
               param1.writeInt(this.mapId);
               param1.writeShort(this.houses.length);
               var _loc2_:uint = 0;
               while(_loc2_ < this.houses.length)
               {
                  param1.writeShort((this.houses[_loc2_] as HouseInformations).getTypeId());
                  (this.houses[_loc2_] as HouseInformations).serialize(param1);
                  _loc2_++;
               }
               param1.writeShort(this.actors.length);
               var _loc3_:uint = 0;
               while(_loc3_ < this.actors.length)
               {
                  param1.writeShort((this.actors[_loc3_] as GameRolePlayActorInformations).getTypeId());
                  (this.actors[_loc3_] as GameRolePlayActorInformations).serialize(param1);
                  _loc3_++;
               }
               param1.writeShort(this.interactiveElements.length);
               var _loc4_:uint = 0;
               while(_loc4_ < this.interactiveElements.length)
               {
                  param1.writeShort((this.interactiveElements[_loc4_] as InteractiveElement).getTypeId());
                  (this.interactiveElements[_loc4_] as InteractiveElement).serialize(param1);
                  _loc4_++;
               }
               param1.writeShort(this.statedElements.length);
               var _loc5_:uint = 0;
               while(_loc5_ < this.statedElements.length)
               {
                  (this.statedElements[_loc5_] as StatedElement).serializeAs_StatedElement(param1);
                  _loc5_++;
               }
               param1.writeShort(this.obstacles.length);
               var _loc6_:uint = 0;
               while(_loc6_ < this.obstacles.length)
               {
                  (this.obstacles[_loc6_] as MapObstacle).serializeAs_MapObstacle(param1);
                  _loc6_++;
               }
               param1.writeShort(this.fights.length);
               var _loc7_:uint = 0;
               while(_loc7_ < this.fights.length)
               {
                  (this.fights[_loc7_] as FightCommonInformations).serializeAs_FightCommonInformations(param1);
                  _loc7_++;
               }
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_MapComplementaryInformationsDataMessage(param1);
      }
      
      public function deserializeAs_MapComplementaryInformationsDataMessage(param1:ICustomDataInput) : void
      {
         var _loc14_:uint = 0;
         var _loc15_:HouseInformations = null;
         var _loc16_:uint = 0;
         var _loc17_:GameRolePlayActorInformations = null;
         var _loc18_:uint = 0;
         var _loc19_:InteractiveElement = null;
         var _loc20_:StatedElement = null;
         var _loc21_:MapObstacle = null;
         var _loc22_:FightCommonInformations = null;
         this.subAreaId = param1.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of MapComplementaryInformationsDataMessage.subAreaId.");
         }
         else
         {
            this.mapId = param1.readInt();
            if(this.mapId < 0)
            {
               throw new Error("Forbidden value (" + this.mapId + ") on element of MapComplementaryInformationsDataMessage.mapId.");
            }
            else
            {
               var _loc2_:uint = param1.readUnsignedShort();
               var _loc3_:uint = 0;
               while(_loc3_ < _loc2_)
               {
                  _loc14_ = param1.readUnsignedShort();
                  _loc15_ = ProtocolTypeManager.getInstance(HouseInformations,_loc14_);
                  _loc15_.deserialize(param1);
                  this.houses.push(_loc15_);
                  _loc3_++;
               }
               var _loc4_:uint = param1.readUnsignedShort();
               var _loc5_:uint = 0;
               while(_loc5_ < _loc4_)
               {
                  _loc16_ = param1.readUnsignedShort();
                  _loc17_ = ProtocolTypeManager.getInstance(GameRolePlayActorInformations,_loc16_);
                  _loc17_.deserialize(param1);
                  this.actors.push(_loc17_);
                  _loc5_++;
               }
               var _loc6_:uint = param1.readUnsignedShort();
               var _loc7_:uint = 0;
               while(_loc7_ < _loc6_)
               {
                  _loc18_ = param1.readUnsignedShort();
                  _loc19_ = ProtocolTypeManager.getInstance(InteractiveElement,_loc18_);
                  _loc19_.deserialize(param1);
                  this.interactiveElements.push(_loc19_);
                  _loc7_++;
               }
               var _loc8_:uint = param1.readUnsignedShort();
               var _loc9_:uint = 0;
               while(_loc9_ < _loc8_)
               {
                  _loc20_ = new StatedElement();
                  _loc20_.deserialize(param1);
                  this.statedElements.push(_loc20_);
                  _loc9_++;
               }
               var _loc10_:uint = param1.readUnsignedShort();
               var _loc11_:uint = 0;
               while(_loc11_ < _loc10_)
               {
                  _loc21_ = new MapObstacle();
                  _loc21_.deserialize(param1);
                  this.obstacles.push(_loc21_);
                  _loc11_++;
               }
               var _loc12_:uint = param1.readUnsignedShort();
               var _loc13_:uint = 0;
               while(_loc13_ < _loc12_)
               {
                  _loc22_ = new FightCommonInformations();
                  _loc22_.deserialize(param1);
                  this.fights.push(_loc22_);
                  _loc13_++;
               }
               return;
            }
         }
      }
   }
}
