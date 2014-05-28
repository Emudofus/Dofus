package com.ankamagames.dofus.network.types.game.prism
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class PrismGeolocalizedInformation extends PrismSubareaEmptyInfo implements INetworkType
   {
      
      public function PrismGeolocalizedInformation() {
         this.prism = new PrismInformation();
         super();
      }
      
      public static const protocolId:uint = 434;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:int = 0;
      
      public var prism:PrismInformation;
      
      override public function getTypeId() : uint {
         return 434;
      }
      
      public function initPrismGeolocalizedInformation(subAreaId:uint = 0, allianceId:uint = 0, worldX:int = 0, worldY:int = 0, mapId:int = 0, prism:PrismInformation = null) : PrismGeolocalizedInformation {
         super.initPrismSubareaEmptyInfo(subAreaId,allianceId);
         this.worldX = worldX;
         this.worldY = worldY;
         this.mapId = mapId;
         this.prism = prism;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.worldX = 0;
         this.worldY = 0;
         this.mapId = 0;
         this.prism = new PrismInformation();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_PrismGeolocalizedInformation(output);
      }
      
      public function serializeAs_PrismGeolocalizedInformation(output:IDataOutput) : void {
         super.serializeAs_PrismSubareaEmptyInfo(output);
         if((this.worldX < -255) || (this.worldX > 255))
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
         }
         else
         {
            output.writeShort(this.worldX);
            if((this.worldY < -255) || (this.worldY > 255))
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
            }
            else
            {
               output.writeShort(this.worldY);
               output.writeInt(this.mapId);
               output.writeShort(this.prism.getTypeId());
               this.prism.serialize(output);
               return;
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismGeolocalizedInformation(input);
      }
      
      public function deserializeAs_PrismGeolocalizedInformation(input:IDataInput) : void {
         super.deserialize(input);
         this.worldX = input.readShort();
         if((this.worldX < -255) || (this.worldX > 255))
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of PrismGeolocalizedInformation.worldX.");
         }
         else
         {
            this.worldY = input.readShort();
            if((this.worldY < -255) || (this.worldY > 255))
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element of PrismGeolocalizedInformation.worldY.");
            }
            else
            {
               this.mapId = input.readInt();
               _id4 = input.readUnsignedShort();
               this.prism = ProtocolTypeManager.getInstance(PrismInformation,_id4);
               this.prism.deserialize(input);
               return;
            }
         }
      }
   }
}
