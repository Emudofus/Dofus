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
      
      public function initPrismGeolocalizedInformation(param1:uint=0, param2:uint=0, param3:int=0, param4:int=0, param5:int=0, param6:PrismInformation=null) : PrismGeolocalizedInformation {
         super.initPrismSubareaEmptyInfo(param1,param2);
         this.worldX = param3;
         this.worldY = param4;
         this.mapId = param5;
         this.prism = param6;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.worldX = 0;
         this.worldY = 0;
         this.mapId = 0;
         this.prism = new PrismInformation();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_PrismGeolocalizedInformation(param1);
      }
      
      public function serializeAs_PrismGeolocalizedInformation(param1:IDataOutput) : void {
         super.serializeAs_PrismSubareaEmptyInfo(param1);
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
               param1.writeInt(this.mapId);
               param1.writeShort(this.prism.getTypeId());
               this.prism.serialize(param1);
               return;
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PrismGeolocalizedInformation(param1);
      }
      
      public function deserializeAs_PrismGeolocalizedInformation(param1:IDataInput) : void {
         super.deserialize(param1);
         this.worldX = param1.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of PrismGeolocalizedInformation.worldX.");
         }
         else
         {
            this.worldY = param1.readShort();
            if(this.worldY < -255 || this.worldY > 255)
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element of PrismGeolocalizedInformation.worldY.");
            }
            else
            {
               this.mapId = param1.readInt();
               _loc2_ = param1.readUnsignedShort();
               this.prism = ProtocolTypeManager.getInstance(PrismInformation,_loc2_);
               this.prism.deserialize(param1);
               return;
            }
         }
      }
   }
}
