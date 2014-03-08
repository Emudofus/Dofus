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
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MapComplementaryInformationsDataInHouseMessage extends MapComplementaryInformationsDataMessage implements INetworkMessage
   {
      
      public function MapComplementaryInformationsDataInHouseMessage() {
         this.currentHouse = new HouseInformationsInside();
         super();
      }
      
      public static const protocolId:uint = 6130;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var currentHouse:HouseInformationsInside;
      
      override public function getMessageId() : uint {
         return 6130;
      }
      
      public function initMapComplementaryInformationsDataInHouseMessage(param1:uint=0, param2:uint=0, param3:Vector.<HouseInformations>=null, param4:Vector.<GameRolePlayActorInformations>=null, param5:Vector.<InteractiveElement>=null, param6:Vector.<StatedElement>=null, param7:Vector.<MapObstacle>=null, param8:Vector.<FightCommonInformations>=null, param9:HouseInformationsInside=null) : MapComplementaryInformationsDataInHouseMessage {
         super.initMapComplementaryInformationsDataMessage(param1,param2,param3,param4,param5,param6,param7,param8);
         this.currentHouse = param9;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.currentHouse = new HouseInformationsInside();
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_MapComplementaryInformationsDataInHouseMessage(param1);
      }
      
      public function serializeAs_MapComplementaryInformationsDataInHouseMessage(param1:IDataOutput) : void {
         super.serializeAs_MapComplementaryInformationsDataMessage(param1);
         this.currentHouse.serializeAs_HouseInformationsInside(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_MapComplementaryInformationsDataInHouseMessage(param1);
      }
      
      public function deserializeAs_MapComplementaryInformationsDataInHouseMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.currentHouse = new HouseInformationsInside();
         this.currentHouse.deserialize(param1);
      }
   }
}
