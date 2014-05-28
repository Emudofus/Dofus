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
      
      public function initAbstractContactInformations(accountId:uint = 0, accountName:String = "") : AbstractContactInformations {
         this.accountId = accountId;
         this.accountName = accountName;
         return this;
      }
      
      public function reset() : void {
         this.accountId = 0;
         this.accountName = "";
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_AbstractContactInformations(output);
      }
      
      public function serializeAs_AbstractContactInformations(output:IDataOutput) : void {
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         else
         {
            output.writeInt(this.accountId);
            output.writeUTF(this.accountName);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AbstractContactInformations(input);
      }
      
      public function deserializeAs_AbstractContactInformations(input:IDataInput) : void {
         this.accountId = input.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of AbstractContactInformations.accountId.");
         }
         else
         {
            this.accountName = input.readUTF();
            return;
         }
      }
   }
}
