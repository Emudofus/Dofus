package com.ankamagames.dofus.network.types.game.friend
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class AbstractContactInformations extends Object implements INetworkType
   {
      
      public function AbstractContactInformations() {
         super();
      }
      
      public static const protocolId:uint = 380;
      
      public var accountId:uint = 0;
      
      public var accountName:String = "";
      
      public function getTypeId() : uint {
         return 380;
      }
      
      public function initAbstractContactInformations(param1:uint=0, param2:String="") : AbstractContactInformations {
         this.accountId = param1;
         this.accountName = param2;
         return this;
      }
      
      public function reset() : void {
         this.accountId = 0;
         this.accountName = "";
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_AbstractContactInformations(param1);
      }
      
      public function serializeAs_AbstractContactInformations(param1:IDataOutput) : void {
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         else
         {
            param1.writeInt(this.accountId);
            param1.writeUTF(this.accountName);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AbstractContactInformations(param1);
      }
      
      public function deserializeAs_AbstractContactInformations(param1:IDataInput) : void {
         this.accountId = param1.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of AbstractContactInformations.accountId.");
         }
         else
         {
            this.accountName = param1.readUTF();
            return;
         }
      }
   }
}
