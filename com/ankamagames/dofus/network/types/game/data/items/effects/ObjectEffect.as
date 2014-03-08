package com.ankamagames.dofus.network.types.game.data.items.effects
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ObjectEffect extends Object implements INetworkType
   {
      
      public function ObjectEffect() {
         super();
      }
      
      public static const protocolId:uint = 76;
      
      public var actionId:uint = 0;
      
      public function getTypeId() : uint {
         return 76;
      }
      
      public function initObjectEffect(actionId:uint=0) : ObjectEffect {
         this.actionId = actionId;
         return this;
      }
      
      public function reset() : void {
         this.actionId = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectEffect(output);
      }
      
      public function serializeAs_ObjectEffect(output:IDataOutput) : void {
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element actionId.");
         }
         else
         {
            output.writeShort(this.actionId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectEffect(input);
      }
      
      public function deserializeAs_ObjectEffect(input:IDataInput) : void {
         this.actionId = input.readShort();
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element of ObjectEffect.actionId.");
         }
         else
         {
            return;
         }
      }
   }
}
