package com.ankamagames.dofus.network.types.secure
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class TrustCertificate extends Object implements INetworkType
   {
      
      public function TrustCertificate() {
         super();
      }
      
      public static const protocolId:uint = 377;
      
      public var id:uint = 0;
      
      public var hash:String = "";
      
      public function getTypeId() : uint {
         return 377;
      }
      
      public function initTrustCertificate(id:uint = 0, hash:String = "") : TrustCertificate {
         this.id = id;
         this.hash = hash;
         return this;
      }
      
      public function reset() : void {
         this.id = 0;
         this.hash = "";
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_TrustCertificate(output);
      }
      
      public function serializeAs_TrustCertificate(output:IDataOutput) : void {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            output.writeInt(this.id);
            output.writeUTF(this.hash);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TrustCertificate(input);
      }
      
      public function deserializeAs_TrustCertificate(input:IDataInput) : void {
         this.id = input.readInt();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of TrustCertificate.id.");
         }
         else
         {
            this.hash = input.readUTF();
            return;
         }
      }
   }
}
