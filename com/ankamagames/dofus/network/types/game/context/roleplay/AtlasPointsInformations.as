package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.context.MapCoordinatesExtended;
   import __AS3__.vec.*;
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
      
      public function initAtlasPointsInformations(type:uint=0, coords:Vector.<MapCoordinatesExtended>=null) : AtlasPointsInformations {
         this.type = type;
         this.coords = coords;
         return this;
      }
      
      public function reset() : void {
         this.type = 0;
         this.coords = new Vector.<MapCoordinatesExtended>();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_AtlasPointsInformations(output);
      }
      
      public function serializeAs_AtlasPointsInformations(output:IDataOutput) : void {
         output.writeByte(this.type);
         output.writeShort(this.coords.length);
         var _i2:uint = 0;
         while(_i2 < this.coords.length)
         {
            (this.coords[_i2] as MapCoordinatesExtended).serializeAs_MapCoordinatesExtended(output);
            _i2++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AtlasPointsInformations(input);
      }
      
      public function deserializeAs_AtlasPointsInformations(input:IDataInput) : void {
         var _item2:MapCoordinatesExtended = null;
         this.type = input.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of AtlasPointsInformations.type.");
         }
         else
         {
            _coordsLen = input.readUnsignedShort();
            _i2 = 0;
            while(_i2 < _coordsLen)
            {
               _item2 = new MapCoordinatesExtended();
               _item2.deserialize(input);
               this.coords.push(_item2);
               _i2++;
            }
            return;
         }
      }
   }
}
