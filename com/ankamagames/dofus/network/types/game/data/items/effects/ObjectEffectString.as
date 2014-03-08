package com.ankamagames.dofus.network.types.game.data.items.effects
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ObjectEffectString extends ObjectEffect implements INetworkType
   {
      
      public function ObjectEffectString() {
         super();
      }
      
      public static const protocolId:uint = 74;
      
      public var value:String = "";
      
      override public function getTypeId() : uint {
         return 74;
      }
      
      public function initObjectEffectString(actionId:uint=0, value:String="") : ObjectEffectString {
         super.initObjectEffect(actionId);
         this.value = value;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.value = "";
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectEffectString(output);
      }
      
      public function serializeAs_ObjectEffectString(output:IDataOutput) : void {
         super.serializeAs_ObjectEffect(output);
         output.writeUTF(this.value);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectEffectString(input);
      }
      
      public function deserializeAs_ObjectEffectString(input:IDataInput) : void {
         super.deserialize(input);
         this.value = input.readUTF();
      }
   }
}
