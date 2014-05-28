package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class HumanOptionOrnament extends HumanOption implements INetworkType
   {
      
      public function HumanOptionOrnament() {
         super();
      }
      
      public static const protocolId:uint = 411;
      
      public var ornamentId:uint = 0;
      
      override public function getTypeId() : uint {
         return 411;
      }
      
      public function initHumanOptionOrnament(ornamentId:uint = 0) : HumanOptionOrnament {
         this.ornamentId = ornamentId;
         return this;
      }
      
      override public function reset() : void {
         this.ornamentId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_HumanOptionOrnament(output);
      }
      
      public function serializeAs_HumanOptionOrnament(output:IDataOutput) : void {
         super.serializeAs_HumanOption(output);
         if(this.ornamentId < 0)
         {
            throw new Error("Forbidden value (" + this.ornamentId + ") on element ornamentId.");
         }
         else
         {
            output.writeShort(this.ornamentId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_HumanOptionOrnament(input);
      }
      
      public function deserializeAs_HumanOptionOrnament(input:IDataInput) : void {
         super.deserialize(input);
         this.ornamentId = input.readShort();
         if(this.ornamentId < 0)
         {
            throw new Error("Forbidden value (" + this.ornamentId + ") on element of HumanOptionOrnament.ornamentId.");
         }
         else
         {
            return;
         }
      }
   }
}
