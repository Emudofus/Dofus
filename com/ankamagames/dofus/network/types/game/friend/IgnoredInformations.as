package com.ankamagames.dofus.network.types.game.friend
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class IgnoredInformations extends AbstractContactInformations implements INetworkType
   {
      
      public function IgnoredInformations() {
         super();
      }
      
      public static const protocolId:uint = 106;
      
      override public function getTypeId() : uint {
         return 106;
      }
      
      public function initIgnoredInformations(accountId:uint = 0, accountName:String = "") : IgnoredInformations {
         super.initAbstractContactInformations(accountId,accountName);
         return this;
      }
      
      override public function reset() : void {
         super.reset();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_IgnoredInformations(output);
      }
      
      public function serializeAs_IgnoredInformations(output:IDataOutput) : void {
         super.serializeAs_AbstractContactInformations(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_IgnoredInformations(input);
      }
      
      public function deserializeAs_IgnoredInformations(input:IDataInput) : void {
         super.deserialize(input);
      }
   }
}
