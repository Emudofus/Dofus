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
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MapComplementaryInformationsWithCoordsMessage extends MapComplementaryInformationsDataMessage implements INetworkMessage
   {
      
      public function MapComplementaryInformationsWithCoordsMessage() {
         super();
      }
      
      public static const protocolId:uint = 6268;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      override public function getMessageId() : uint {
         return 6268;
      }
      
      public function initMapComplementaryInformationsWithCoordsMessage(param1:uint=0, param2:uint=0, param3:Vector.<HouseInformations>=null, param4:Vector.<GameRolePlayActorInformations>=null, param5:Vector.<InteractiveElement>=null, param6:Vector.<StatedElement>=null, param7:Vector.<MapObstacle>=null, param8:Vector.<FightCommonInformations>=null, param9:int=0, param10:int=0) : MapComplementaryInformationsWithCoordsMessage {
         super.initMapComplementaryInformationsDataMessage(param1,param2,param3,param4,param5,param6,param7,param8);
         this.worldX = param9;
         this.worldY = param10;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.worldX = 0;
         this.worldY = 0;
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
         this.serializeAs_MapComplementaryInformationsWithCoordsMessage(param1);
      }
      
      public function serializeAs_MapComplementaryInformationsWithCoordsMessage(param1:IDataOutput) : void {
         super.serializeAs_MapComplementaryInformationsDataMessage(param1);
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
         }
         else
         {
            param1.writeShort(this.worldX);
            if(this.worldY < -255 || this.worldY > 255)
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
            }
            else
            {
               param1.writeShort(this.worldY);
               return;
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_MapComplementaryInformationsWithCoordsMessage(param1);
      }
      
      public function deserializeAs_MapComplementaryInformationsWithCoordsMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.worldX = param1.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of MapComplementaryInformationsWithCoordsMessage.worldX.");
         }
         else
         {
            this.worldY = param1.readShort();
            if(this.worldY < -255 || this.worldY > 255)
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element of MapComplementaryInformationsWithCoordsMessage.worldY.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
