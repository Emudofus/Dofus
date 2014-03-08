package com.ankamagames.dofus.network.types.game.social
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class AbstractSocialGroupInfos extends Object implements INetworkType
   {
      
      public function AbstractSocialGroupInfos() {
         super();
      }
      
      public static const protocolId:uint = 416;
      
      public function getTypeId() : uint {
         return 416;
      }
      
      public function initAbstractSocialGroupInfos() : AbstractSocialGroupInfos {
         return this;
      }
      
      public function reset() : void {
      }
      
      public function serialize(param1:IDataOutput) : void {
      }
      
      public function serializeAs_AbstractSocialGroupInfos(param1:IDataOutput) : void {
      }
      
      public function deserialize(param1:IDataInput) : void {
      }
      
      public function deserializeAs_AbstractSocialGroupInfos(param1:IDataInput) : void {
      }
   }
}
