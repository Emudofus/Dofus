package com.ankamagames.dofus.network.types.secure
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class TrustCertificate extends Object implements INetworkType
   {
      
      public function TrustCertificate()
      {
         super();
      }
      
      public static const protocolId:uint = 377;
      
      public var id:uint = 0;
      
      public var hash:String = "";
      
      public function getTypeId() : uint
      {
         return 377;
      }
      
      public function initTrustCertificate(param1:uint = 0, param2:String = "") : TrustCertificate
      {
         this.id = param1;
         this.hash = param2;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.hash = "";
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_TrustCertificate(param1);
      }
      
      public function serializeAs_TrustCertificate(param1:ICustomDataOutput) : void
      {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            param1.writeInt(this.id);
            param1.writeUTF(this.hash);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_TrustCertificate(param1);
      }
      
      public function deserializeAs_TrustCertificate(param1:ICustomDataInput) : void
      {
         this.id = param1.readInt();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of TrustCertificate.id.");
         }
         else
         {
            this.hash = param1.readUTF();
            return;
         }
      }
   }
}
