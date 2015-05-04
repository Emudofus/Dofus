package com.ankamagames.dofus.network.types.game.paddock
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class MountInformationsForPaddock extends Object implements INetworkType
   {
      
      public function MountInformationsForPaddock()
      {
         super();
      }
      
      public static const protocolId:uint = 184;
      
      public var modelId:uint = 0;
      
      public var name:String = "";
      
      public var ownerName:String = "";
      
      public function getTypeId() : uint
      {
         return 184;
      }
      
      public function initMountInformationsForPaddock(param1:uint = 0, param2:String = "", param3:String = "") : MountInformationsForPaddock
      {
         this.modelId = param1;
         this.name = param2;
         this.ownerName = param3;
         return this;
      }
      
      public function reset() : void
      {
         this.modelId = 0;
         this.name = "";
         this.ownerName = "";
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_MountInformationsForPaddock(param1);
      }
      
      public function serializeAs_MountInformationsForPaddock(param1:ICustomDataOutput) : void
      {
         if(this.modelId < 0)
         {
            throw new Error("Forbidden value (" + this.modelId + ") on element modelId.");
         }
         else
         {
            param1.writeByte(this.modelId);
            param1.writeUTF(this.name);
            param1.writeUTF(this.ownerName);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_MountInformationsForPaddock(param1);
      }
      
      public function deserializeAs_MountInformationsForPaddock(param1:ICustomDataInput) : void
      {
         this.modelId = param1.readByte();
         if(this.modelId < 0)
         {
            throw new Error("Forbidden value (" + this.modelId + ") on element of MountInformationsForPaddock.modelId.");
         }
         else
         {
            this.name = param1.readUTF();
            this.ownerName = param1.readUTF();
            return;
         }
      }
   }
}
