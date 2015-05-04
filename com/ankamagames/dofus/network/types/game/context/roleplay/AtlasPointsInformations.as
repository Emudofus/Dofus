package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.context.MapCoordinatesExtended;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AtlasPointsInformations extends Object implements INetworkType
   {
      
      public function AtlasPointsInformations()
      {
         this.coords = new Vector.<MapCoordinatesExtended>();
         super();
      }
      
      public static const protocolId:uint = 175;
      
      public var type:uint = 0;
      
      public var coords:Vector.<MapCoordinatesExtended>;
      
      public function getTypeId() : uint
      {
         return 175;
      }
      
      public function initAtlasPointsInformations(param1:uint = 0, param2:Vector.<MapCoordinatesExtended> = null) : AtlasPointsInformations
      {
         this.type = param1;
         this.coords = param2;
         return this;
      }
      
      public function reset() : void
      {
         this.type = 0;
         this.coords = new Vector.<MapCoordinatesExtended>();
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_AtlasPointsInformations(param1);
      }
      
      public function serializeAs_AtlasPointsInformations(param1:ICustomDataOutput) : void
      {
         param1.writeByte(this.type);
         param1.writeShort(this.coords.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.coords.length)
         {
            (this.coords[_loc2_] as MapCoordinatesExtended).serializeAs_MapCoordinatesExtended(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AtlasPointsInformations(param1);
      }
      
      public function deserializeAs_AtlasPointsInformations(param1:ICustomDataInput) : void
      {
         var _loc4_:MapCoordinatesExtended = null;
         this.type = param1.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of AtlasPointsInformations.type.");
         }
         else
         {
            var _loc2_:uint = param1.readUnsignedShort();
            var _loc3_:uint = 0;
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
