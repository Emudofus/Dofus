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
      
      public function initIgnoredInformations(param1:uint=0, param2:String="") : IgnoredInformations {
         super.initAbstractContactInformations(param1,param2);
         return this;
      }
      
      override public function reset() : void {
         super.reset();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_IgnoredInformations(param1);
      }
      
      public function serializeAs_IgnoredInformations(param1:IDataOutput) : void {
         super.serializeAs_AbstractContactInformations(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_IgnoredInformations(param1);
      }
      
      public function deserializeAs_IgnoredInformations(param1:IDataInput) : void {
         super.deserialize(param1);
      }
   }
}
