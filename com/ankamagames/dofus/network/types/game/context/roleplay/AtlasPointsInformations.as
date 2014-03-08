package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.context.MapCoordinatesExtended;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class AtlasPointsInformations extends Object implements INetworkType
   {
      
      public function AtlasPointsInformations() {
         this.coords = new Vector.<MapCoordinatesExtended>();
         super();
      }
      
      public static const protocolId:uint = 175;
      
      public var type:uint = 0;
      
      public var coords:Vector.<MapCoordinatesExtended>;
      
      public function getTypeId() : uint {
         return 175;
      }
      
      public function initAtlasPointsInformations(param1:uint=0, param2:Vector.<MapCoordinatesExtended>=null) : AtlasPointsInformations {
         this.type = param1;
         this.coords = param2;
         return this;
      }
      
      public function reset() : void {
         this.type = 0;
         this.coords = new Vector.<MapCoordinatesExtended>();
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_AtlasPointsInformations(param1);
      }
      
      public function serializeAs_AtlasPointsInformations(param1:IDataOutput) : void {
         param1.writeByte(this.type);
         param1.writeShort(this.coords.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.coords.length)
         {
            (this.coords[_loc2_] as MapCoordinatesExtended).serializeAs_MapCoordinatesExtended(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AtlasPointsInformations(param1);
      }
      
      public function deserializeAs_AtlasPointsInformations(param1:IDataInput) : void {
         var _loc4_:MapCoordinatesExtended = null;
         this.type = param1.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of AtlasPointsInformations.type.");
         }
         else
         {
            _loc2_ = param1.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = new MapCoordinatesExtended();
               _loc4_.deserialize(param1);
               this.coords.push(_loc4_);
               _loc3_++;
            }
            return;
         }
      }
   }
}
